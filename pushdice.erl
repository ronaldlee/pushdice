-module(pushdice).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).

-record(game_user, {user_id, name, plat_id, plat_type,last_play_date,consecutive_days_played,is_unlocked,coins}).

-define(ONE_DAY_SECS,86400).
-define(TWO_DAY_SECS,172800).
-define(USER_SESSION_EXPIRATION,86400).

%% out(Arg) ->
%%     Uri = yaws_api:request_url(Arg),
%%     io:format("aaa~s",[Uri#url.path]),
%%     Method = method(Arg),
%%     handle(Method, Arg).
%% 
%% method(Arg) ->
%%     io:format("bbb"),
%%     Rec = Arg#arg.req,
%%     Rec#http_request.method.
%% 
%% handle('GET', _Arg) ->
%%     io:format("ccc"),
%%     Boo = {html, "yooo"},
%%     io:format("ddd"),
%%     Boo.

%% out(Arg) ->
%%       Uri = yaws_api:request_url(Arg),
%%       io:format(Uri),
%%       Boo = {html, "yooo"},
%%       Boo.

processFBFriendsJson([],FriendsList ) ->
  FriendsList;
processFBFriendsJson([FriendData|Rest],FriendsList ) ->
  {struct,[NameData,IdData]} = FriendData,
  {_,Name} = NameData,
  {_,FBID} = IdData,
  NewFBData = [{name,Name},{id,FBID}],
  %NewFBData = {name,io_lib:format("~s",[Name])},{id,io_lib:format("~s",[IdData])},
  NewFriendsList = lists:append(FriendsList,[NewFBData]),
io:format("boo ~w~n",[NewFriendsList]),
  processFBFriendsJson(Rest,NewFriendsList).

populateFriendsList([],FBFriendsList,GamePlayersList) ->
  {FBFriendsList,GamePlayersList};
populateFriendsList([FB_data|Rest],FBFriendsList,GamePlayersList) ->
  {FB_UID,FB_ID_NAME} = FB_data,
%io:format("fb uid: ~s~n",[FB_UID]),
  %check if FB user is also a player
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE plat_id='~s'",[FB_UID]),
  SelectResult = emysql:execute(pushdice_pool, SelectSQL),
  Recs = emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)),
  SelectLength = length(Recs),
  case SelectLength of
    1->
     [{game_user,NewUserId,FoundUsername,FoundId,FoundType,{datetime,{{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}},
             ConsecDaysPlayed,IsUnlocked,Coins} | _ ] = Recs,

      {FBIDKey,FBSTRUCT} = FB_data,
      {struct,[FBNAME,FBID]} = FBSTRUCT,
      New_user_data = {FBIDKey,{struct,[FBNAME,FBID,{uid,NewUserId}]}},
%io:format("hihi: ~w~n",[New_user_data]),
      NewGamePlayersList = lists:append(GamePlayersList,[New_user_data]),
      populateFriendsList(Rest,FBFriendsList,NewGamePlayersList);
    0->
      NewFBFriendsList = lists:append(FBFriendsList,[FB_data]),
      populateFriendsList(Rest,NewFBFriendsList,GamePlayersList);
    true->
      populateFriendsList(Rest,FBFriendsList,GamePlayersList) 
  end.

%%%%%%%%%%%%%%%%%%%%
out(Arg) ->
     Uri = yaws_api:request_url(Arg),
     io:format("rest: ~s~n",[Uri#url.path]),
     [Path|Rest] = string:tokens(Uri#url.path, "/"),
     Method = (Arg#arg.req)#http_request.method,

     MysqlStatus = application:start(emysql),
     io:format("mysql: ~w~n",[MysqlStatus]),
     Status = try (emysql:add_pool(pushdice_pool, 1, "root", "hellojoe", "localhost", 3306, "pushdice", utf8)) of 
         Val -> 0
     catch
         exit:pool_already_exists -> 
             io:format("throw error already exist ~n",[]),
             1
     end,
     HtmlOut = out(Arg,Rest),
     emysql:remove_pool(pushdice_pool),
     HtmlOut.

out(Arg, ["login", "username", Username, "id", Id, "type", Type, "accesstoken", AccessToken]) -> 
     CryptoStatus = crypto:start(),
     io:format("cryp: ~w~n",[CryptoStatus]),


     SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE name='~s' and plat_id='~s' and plat_type='~s'",[Username,Id,Type]),
     SelectResult = emysql:execute(pushdice_pool, SelectSQL),
     Recs = emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)),
     SelectLength = length(Recs),
     io:format("mysqlllll recs ~w~n",[Recs]),
     %io:format("mysqlllll recs length: ~w~n",[length(Recs)]),

     case SelectLength of 
       0 ->
         InsertSql = io_lib:format("INSERT INTO user (name,plat_id,plat_type,fb_accesstoken,consecutive_days_played,coins,last_play_date) values ('~s','~s','~s','~s','1','1000',NULL)",[Username,Id,Type,AccessToken]),
         io:format("mysqlllll insert sql: ~s~n",[InsertSql]),
         InsertResult = emysql:execute(pushdice_pool, InsertSql),
         io:format("mysqlllll insert result: ~w~n",[InsertResult]),

         case InsertResult of 
            {ok_packet,_,_,NewUserId,_,_,[]} -> 
                IsNewAccount = true,
                true;
            _ ->
              IsNewAccount = false,
              NewUserId = "unknown"
         end;
       1 ->
         IsNewAccount = false,
         io:format("mysqlllll found user~n",[]),
         [{game_user,NewUserId,FoundUsername,FoundId,FoundType,{datetime,{{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}},
             ConsecDaysPlayed,IsUnlocked,Coins} | _ ] = Recs,

         LastPlayTime = calendar:datetime_to_gregorian_seconds({{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}),

         LocalTime = calendar:datetime_to_gregorian_seconds(erlang:localtime()),

         TimeDiff = LocalTime-LastPlayTime,

         %if last play time is greater than 1 day and less than 2 days -> consecutive days
%but need to prevent from adding consecutive days for every login on the same day!!!
         if ((TimeDiff > ?ONE_DAY_SECS) and (TimeDiff < ?TWO_DAY_SECS)) ->
             UpdateConsecDaysPlayedSQL = io_lib:format("Update user set last_play_date=NULL,consecutive_days_played=consecutive_days_played+1 WHERE user_id='~w'",[NewUserId]),
             UpdateConsecDaysPlayedResult = emysql:execute(pushdice_pool, UpdateConsecDaysPlayedSQL);
             true ->
             %not consec day play, reset to 1
             UpdateConsecDaysPlayedSQL = io_lib:format("Update user set last_play_date=NULL,consecutive_days_played=1 WHERE user_id='~w'",[NewUserId]),
             UpdateConsecDaysPlayedResult = emysql:execute(pushdice_pool, UpdateConsecDaysPlayedSQL)
         end,
         io:format("mysqlllll found LastPlayTime ~w, ~w ~w~n",[LastPlayTime, LocalTime, TimeDiff]),
         io:format("mysqlllll found user id ~w~n",[NewUserId])
     end,
     io:format("user id to use ~w~n",[NewUserId]),

     %MemcachedStatus = erlmc:start(),
     %io:format("memcached: ~w~n",[MemcachedStatus]),

     %ReturnUserData = erlmc:get(UserCacheKey),
     %io:format("memcached user data ~w~n",[binary_to_term(ReturnUserData)]),

     %io:format("mysqlllll done ~w~n",[InsertResult]),

     {Mega, Sec, Micro} = now(),
     Timestamp = Mega * 1000000 * 1000000 + Sec * 1000000 + Micro,
     SessionId = string:concat(integer_to_list(NewUserId),integer_to_list(Timestamp)),

     UserData = {{user_id,NewUserId},{name,Username},{plat_id,Id},{plat_type,Type},{is_new_acct,IsNewAccount}},
     io:format("user data ~w~n",[UserData]),
     UserSessionCacheKey = string:concat("pd_session_",SessionId),
     erlmc:set(UserSessionCacheKey,term_to_binary(UserData),?USER_SESSION_EXPIRATION),
     io:format("done set memcached ~n",[]),

     SessionJson= mochijson2:encode({struct, [{session,list_to_binary(SessionId)}]}),
     {html, SessionJson};

out(Arg, ["login", "username", Username, "id", Id, "type", Type]) -> 
     out(Arg,["login", "username", Username, "id", Id, "type", Type, "accesstoken", ""]);

out(Arg, ["user", "session", Session]) -> 
     %get user info from session
     FetchUserSessionCacheKey = string:concat("pd_session_",Session),
     FetchUserBinData = erlmc:get(FetchUserSessionCacheKey),
     FetchUserData = binary_to_term(FetchUserBinData),
     {{user_id,FetchUserId},{name,FetchUsername},{plat_id,FetchPlatId},{plat_type,FetchPlatType},{is_new_acct,IsNewAcct}} = FetchUserData,

     %use FetchUserId to fetch more user data from db
     FetchUserSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE user_id='~w'",[FetchUserId]),
     io:format("fetch user sql: recs: ~s~n",[FetchUserSQL]),
     FetchUserResult = emysql:execute(pushdice_pool, FetchUserSQL),
     Recs = emysql_util:as_record(FetchUserResult, game_user, record_info(fields, game_user)),
     io:format("fetch user by session: recs: ~w~n",[Recs]),

     %if consecutive days play >= 1, consecutive_days_played = true
     DailyBonus = true,

     case Recs of 
         [{game_user,UserId,UserName,UserPlatId,UserPlatType,{datetime,{{UserLastPlayYr,UserLastPlayM,UserLastPlayDay},{UserLastPlayHr,UserLastPlayMin,UserLastPlaySec}}},UserConsecDaysPlayed,UserIsUnlocked,UserCoins}] ->
             UserInfoJson =  [{user_id,UserId},{name,UserName},{plat_id,UserPlatId},{plat_type,UserPlatType},{coins,UserCoins},{unlock,UserIsUnlocked},{dailybonus,DailyBonus},{is_new_acct,IsNewAcct}],
             UserInfoJsonStr = mochijson2:encode({struct, UserInfoJson}),
             {html, UserInfoJsonStr};
          true ->
             {html, "{'code':'-1', 'msg':'Fail to get user data from session.'}"}
      end;

out(Arg, ["friends", "accesstoken", AccessToken]) -> 
     FBFriendsGraphURL = io_lib:format("https://graph.facebook.com/me/friends?&limit=5000&offset=0&access_token=~s",[AccessToken]),
     io:format("fetch friends url: ~s~n",[FBFriendsGraphURL]),
     inets:start(),
     {ok, {{Version, Code, ReasonPhrase}, Headers, Body}} = httpc:request(FBFriendsGraphURL),
     io:format("http code: ~w~n",[Code]),
     case Code of
         200 ->
           %io:format("200 body: ~s~n",[Body]),
           Json = mochijson2:decode(Body),
           %io:format("200 json: ~w~n",[Json]),
           {struct,[Data,Pagin]} = Json,
           %io:format("200 data: ~w~n",[Data]),
           {<<100,97,116,97>>,FriendsList} = Data,
           io:format("200 friends: ~w~n",[FriendsList]),

           TrimmdFriendsList = processFBFriendsJson(FriendsList,[]),
           io:format("200 trimmed friends: ~w~n",[TrimmdFriendsList]),

           ConvertFun = fun([{name,X},{id,Y}]) -> 
               io:format("uuu ~s,~s~n",[binary_to_list(X),binary_to_list(Y)]), 
               %{struct,[{name,io_lib:format("~s",[binary_to_list(X)])},{id,io_lib:format("~s",[binary_to_list(Y)])}]} 
               {Y,{struct,[{name,X},{fbuid,Y}]}} 
           end,

           %ConvertFun = fun({X,Y}) -> {X,Y} end,
           StringConverted = lists:map(ConvertFun, TrimmdFriendsList),
%io:format("out1: ~w~n",[StringConverted]),


           {FBFriendsList,GamePlayersList} = populateFriendsList(StringConverted,[],[]),
%io:format("fb friend: ~w~n",[FBFriendsList]),
io:format("player friend: ~w~n",[GamePlayersList]),

           %Output = mochijson2:encode({struct, StringConverted}),
           Output = mochijson2:encode({struct,[{fb_friends,{struct,FBFriendsList}},{players,{struct,GamePlayersList}}]}),

           %Output = mochijson2:encode({struct, TrimmdFriendsList}),
%io:format("out: ~w~n",[Output]),
io:format("out: ~n",[]),

           {html, Output};
         400 ->
           {html, Body};
         true ->
           {html, Body}
     end.

     %{ok, Result} = httpc:request(FBFriendsGraphURL),
     %{html, Result}.


    
%% out(Arg, [Fbusername]) -> 
%%     inets:start(),
%%     {ok, {{Version, 200, ReasonPhrase}, Headers, Body}} = httpc:request("http://www.erlang.org"),
%%     {html, Body}.
