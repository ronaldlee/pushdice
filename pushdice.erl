-module(pushdice).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).

-record(game_user, {user_id, name, plat_id, plat_type,last_play_date,consecutive_days_played,is_unlocked,coins}).

-define(ONE_DAY_SECS,86400).
-define(TWO_DAY_SECS,172800).
-define(USER_SESSION_EXPIRATION,86400).
-define(INAPP_PURCHASE_ITEM_TYPE,1).

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
  NewFriendsList = lists:append(FriendsList,[NewFBData]),
%io:format("boo ~w~n",[NewFriendsList]),
  processFBFriendsJson(Rest,NewFriendsList).

populateFriendsList([],FBFriendsList,GamePlayersList,PushFriendsGamesList) ->
  {FBFriendsList,GamePlayersList};
populateFriendsList([FB_data|Rest],FBFriendsList,GamePlayersList,PushFriendsGamesList) ->
  {FB_UID,FB_ID_NAME} = FB_data,
%io:format("***** populateFriendsList: uid: ~s~n",[FB_UID]),
  %check if FB user is also a player
  Recs = usermodel:getUserByPlatID(pushdice_pool,FB_UID,fb),
  SelectLength = length(Recs),
  case SelectLength of
    1->
     [{game_user,NewUserId,FoundUsername,FoundId,FoundType,{datetime,{{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}},
             ConsecDaysPlayed,IsUnlocked,Coins} | _ ] = Recs,
io:format("is game player:fb uid ~s~n",[FB_UID]),

      %check if the player already has a game playing with this user.
      case lists:member(FB_UID,PushFriendsGamesList) of
        true ->
          populateFriendsList(Rest,FBFriendsList,GamePlayersList,PushFriendsGamesList); %skip this friends coz it has a game session currently 
        false ->
          {FBIDKey,FBSTRUCT} = FB_data,
          {struct,[FBNAME,FBID]} = FBSTRUCT,
          New_user_data = {FBIDKey,{struct,[FBNAME,FBID,{uid,NewUserId}]}},
          NewGamePlayersList = lists:append(GamePlayersList,[New_user_data]),
          populateFriendsList(Rest,FBFriendsList,NewGamePlayersList,PushFriendsGamesList)
      end;
    0->
      NewFBFriendsList = lists:append(FBFriendsList,[FB_data]),
      populateFriendsList(Rest,NewFBFriendsList,GamePlayersList,PushFriendsGamesList);
    true->
      populateFriendsList(Rest,FBFriendsList,GamePlayersList,PushFriendsGamesList) 
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

out(Arg, ["login", "username", Username, "id", Id, "type", Type, "accesstoken", AccessToken, "ios_pushtoken", IOSPushToken]) -> 
     CryptoStatus = crypto:start(),
     io:format("cryp: ~w~n",[CryptoStatus]),

     Recs = usermodel:getUserByUsernameAndPlatID(pushdice_pool,Username,Id,Type),
     SelectLength = length(Recs),
     io:format("mysqlllll recs ~w~n",[Recs]),
     %io:format("mysqlllll recs length: ~w~n",[length(Recs)]),

     case SelectLength of 
       0 ->
         %new user, no daily bonus
         DailyBonus = false, 

         InsertResult = usermodel:createUser(pushdice_pool,Username,Id,Type,AccessToken,IOSPushToken),
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

         %update ios token
         usermodel:updateIOSPushToken(pushdice_pool,integer_to_list(NewUserId),IOSPushToken),

         LastPlayTime = calendar:datetime_to_gregorian_seconds({{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}),

         LocalTime = calendar:datetime_to_gregorian_seconds(erlang:localtime()),

         TimeDiff = LocalTime-LastPlayTime,

         %if last play time is greater than 1 day and less than 2 days -> consecutive days
%but need to prevent from adding consecutive days for every login on the same day!!!
         if ((TimeDiff > ?ONE_DAY_SECS) and (TimeDiff < ?TWO_DAY_SECS)) ->
             %consecutive play, daily bonus
             DailyBonus = true,

             UpdateConsecDaysPlayedResult = usermodel:incrementLastPlayAndConsecDaysPlayed(pushdice_pool,integer_to_list(NewUserId));
             true ->
             %not consec day play, reset to 1
             DailyBonus = false,
             UpdateConsecDaysPlayedResult = usermodel:resetLastPlayAndConsecDaysPlayed(pushdice_pool,integer_to_list(NewUserId))
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

     UserData = {{user_id,NewUserId},{name,Username},{plat_id,Id},{plat_type,Type},{is_new_acct,IsNewAccount},{dailybonus,DailyBonus}},
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
     %FetchUserSessionCacheKey = string:concat("pd_session_",Session),
     %FetchUserBinData = erlmc:get(FetchUserSessionCacheKey),
     %FetchUserData = binary_to_term(FetchUserBinData),
     %{{user_id,FetchUserId},{name,FetchUsername},{plat_id,FetchPlatId},{plat_type,FetchPlatType},{is_new_acct,IsNewAcct},{dailybonus,DailyBonus}} = FetchUserData,

     {{user_id,FetchUserId},{name,FetchUsername},{plat_id,FetchPlatId},{plat_type,FetchPlatType},{is_new_acct,IsNewAcct},{dailybonus,DailyBonus}} = usermodel:getUserSessionData(Session),

io:format("session: ~w~w~w~w~w~n",[FetchUsername,FetchPlatId,FetchPlatType,IsNewAcct,DailyBonus]),

     Recs = usermodel:getUser(pushdice_pool,integer_to_list(FetchUserId)),
     io:format("fetch user by session: recs: ~w~n",[Recs]),

     case Recs of 
         [{game_user,UserId,UserName,UserPlatId,UserPlatType,{datetime,{{UserLastPlayYr,UserLastPlayM,UserLastPlayDay},{UserLastPlayHr,UserLastPlayMin,UserLastPlaySec}}},UserConsecDaysPlayed,UserIsUnlocked,UserCoins}] ->
             UserInfoJson =  [{user_id,UserId},{name,UserName},{plat_id,UserPlatId},{plat_type,UserPlatType},{coins,UserCoins},{unlock,UserIsUnlocked},{is_new_acct,IsNewAcct},{dailybonus,DailyBonus}],
             UserInfoJsonStr = mochijson2:encode({struct, UserInfoJson}),
             {html, UserInfoJsonStr};
          true ->
             {html, "{'code':'-1', 'msg':'Fail to get user data from session.'}"}
      end;

out(Arg, ["friends", "accesstoken", AccessToken, "session", Session]) -> 
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
               %io:format("uuu ~s,~s~n",[binary_to_list(X),binary_to_list(Y)]), 
               {Y,{struct,[{name,X},{fbuid,Y}]}} 
           end,

           StringConverted = lists:map(ConvertFun, TrimmdFriendsList),
io:format("string converted: ~w~n",[StringConverted]), 

           FetchUserData = usermodel:getUserSessionData(Session),

           case FetchUserData of
               {{user_id,FetchUserId},{name,FetchUsername},{plat_id,FetchPlatId},{plat_type,FetchPlatType},{is_new_acct,IsNewAcct},{dailybonus,DailyBonus}} ->
                 %get the user id, for getting the friends_game map from redis to see 
                 %if friends already have a game with this user.
                 %can we grab the game list and put it in a hashtable?
                 PushFriendsGamesKey = io_lib:format("pfg_~s",[FetchPlatId]),

io:format("PushFriendsGamesKey: ~s~n",[PushFriendsGamesKey]), 

                 {ok, C} = eredis:start_link(),
                 PushFriendsGamesListResponse = eredis:q(C, ["SMEMBERS", PushFriendsGamesKey]),
                 eredis:stop(C),

                 %FakeResponse = {ok, [1200561,223593]},

                 case PushFriendsGamesListResponse of 
                 %case FakeResponse of 
                   {ok, PushFriendsGamesList} ->
io:format("has friends games set: ~w~n",[PushFriendsGamesList]), 
                     {FBFriendsList,GamePlayersList} = populateFriendsList(StringConverted,[],[],PushFriendsGamesList),
%io:format("fb friend: ~w~n",[FBFriendsList]),
io:format("player friend: ~w~n",[GamePlayersList]),

                     Output = mochijson2:encode({struct,[{fb_friends,{struct,FBFriendsList}},{players,{struct,GamePlayersList}}]}),
                     {html, Output};
                   true ->
io:format("no friends games set: ~n"), 
                     {FBFriendsList,GamePlayersList} = populateFriendsList(StringConverted,[],[],[]),

                     Output = mochijson2:encode({struct,[{fb_friends,{struct,FBFriendsList}},{players,{struct,GamePlayersList}}]}),
                     {html, Output}
                 end;
               true ->
io:format("session error! ~n"), 
                 {html, "{'code':'-1', 'msg':'Fail to get friends data.'}"}
           end;
         400 ->
           {html, "{'code':'-1', 'msg':'Fail to get friends data.'}"};
         true ->
           {html, "{'code':'-1', 'msg':'Fail to get friends data.'}"}
     end;
    
out(Arg, ["inapp_purchase","key",Key,"session", Session]) -> 
io:format("inapp purchases ~n"),
     Recs = itemmodel:getItemPropByTypeAndName(pushdice_pool,?INAPP_PURCHASE_ITEM_TYPE,Key),
io:format("inapp purchases A: ~w ~n",[Recs]),
     SelectLength = length(Recs),
     case SelectLength of
       1->
         [{item_prop,ItemPropName,ItemPropValue}] = Recs,
io:format("inapp purchases ItemPropValue: ~w ~n",[ItemPropValue]),

         case usermodel:getUserSessionData(Session) of
             {{user_id,FetchUserId},{name,FetchUsername},{plat_id,FetchPlatId},{plat_type,FetchPlatType},{is_new_acct,IsNewAcct},{dailybonus,DailyBonus}} ->

io:format("inapp purchases: ~w~w~w~w~w~n",[FetchUsername,FetchPlatId,FetchPlatType,IsNewAcct,DailyBonus]),
io:format("inapp purchases coins: ~s~n",[ItemPropValue]),
                 usermodel:incrementCoins(pushdice_pool,integer_to_list(FetchUserId),ItemPropValue),
                 {html, "{'code':'0', 'msg':'ok'}"};
             true ->
io:format("BOOOOO ~n"),
                 {html, "{'code':'-1', 'msg':'Fail to increment coins.'}"}
         end;
       true->
         {html, "{'code':'-1', 'msg':'Fail to increment coins.'}"}
     end.
