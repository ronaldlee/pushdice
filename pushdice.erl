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

out(Arg) ->
     Uri = yaws_api:request_url(Arg),
     io:format("rest: ~s~n",[Uri#url.path]),
     [Path|Rest] = string:tokens(Uri#url.path, "/"),
     Method = (Arg#arg.req)#http_request.method,
     out(Arg,Rest).

out(Arg, ["login", "username", Username, "id", Id, "type", Type, "accesstoken", AccessToken]) -> 
     CryptoStatus = crypto:start(),
     io:format("cryp: ~w~n",[CryptoStatus]),
     MysqlStatus = application:start(emysql),
     io:format("mysql: ~w~n",[MysqlStatus]),

     Status = try (emysql:add_pool(pushdice_pool, 1, "root", "hellojoe", "localhost", 3306, "pushdice", utf8)) of 
         Val -> 0
     catch
         exit:pool_already_exists -> 
             io:format("throw error already exist ~n",[]),
             1
     end,

     SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE name='~s' and plat_id='~s' and plat_type='~s'",[Username,Id,Type]),
     SelectResult = emysql:execute(pushdice_pool, SelectSQL),
     Recs = emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)),
     SelectLength = length(Recs),
     %io:format("mysqlllll recs ~w~n",[Recs]),
     %io:format("mysqlllll recs length: ~w~n",[length(Recs)]),

     case SelectLength of 
       0 ->
         InsertSql = io_lib:format("INSERT INTO user (name,plat_id,plat_type,fb_accesstoken,consecutive_days_played,last_play_date) values ('~s','~s','~s','~s','1',NULL)",[Username,Id,Type,AccessToken]),
         io:format("mysqlllll insert sql: ~s~n",[InsertSql]),
         InsertResult = emysql:execute(pushdice_pool, InsertSql),
         io:format("mysqlllll insert result: ~w~n",[InsertResult]),

         case InsertResult of 
            {ok_packet,_,_,NewUserId,_,_,[]} -> 
                true;
            _ ->
              NewUserId = "unknown"
         end;
       1 ->
         io:format("mysqlllll found user~n",[]),
         [{game_user,NewUserId,FoundUsername,FoundId,FoundType,{datetime,{{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}},
             ConsecDaysPlayed,IsUnlocked,Coins} | _ ] = Recs,

         LastPlayTime = calendar:datetime_to_gregorian_seconds({{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}),

         LocalTime = calendar:datetime_to_gregorian_seconds(erlang:localtime()),

         TimeDiff = LocalTime-LastPlayTime,

         %if last play time is greater than 1 day and less than 2 days -> consecutive days
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

     MemcachedStatus = erlmc:start(),
     %io:format("memcached: ~w~n",[MemcachedStatus]),

     %ReturnUserData = erlmc:get(UserCacheKey),
     %io:format("memcached user data ~w~n",[binary_to_term(ReturnUserData)]),

     %io:format("mysqlllll done ~w~n",[InsertResult]),

     {Mega, Sec, Micro} = now(),
     Timestamp = Mega * 1000000 * 1000000 + Sec * 1000000 + Micro,
     SessionId = string:concat(integer_to_list(NewUserId),integer_to_list(Timestamp)),

     UserData = {{user_id,NewUserId},{name,Username},{plat_id,Id},{plat_type,Type}},
     io:format("user data ~w~n",[UserData]),
     UserSessionCacheKey = string:concat("pd_session_",SessionId),
     erlmc:set(UserSessionCacheKey,term_to_binary(UserData),?USER_SESSION_EXPIRATION),

     SessionJson= mochijson2:encode({struct, [{session,list_to_binary(SessionId)}]}),
     {html, SessionJson};

out(Arg, ["login", "username", Username, "id", Id, "type", Type]) -> 
     out(Arg,["login", "username", Username, "id", Id, "type", Type, "accesstoken", ""]);

out(Arg, ["user", "session", Session]) -> 
     %get user info from session
     FetchUserSessionCacheKey = string:concat("pd_session_",Session),
     FetchUserBinData = erlmc:get(FetchUserSessionCacheKey),
     FetchUserData = binary_to_term(FetchUserBinData),
     {{user_id,FetchUserId},{name,FetchUsername},{plat_id,FetchPlatId},{plat_type,FetchPlatType}} = FetchUserData,

     %use FetchUserId to fetch more user data from db
     FetchUserSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE user_id='~w'",[FetchUserId]),
     io:format("fetch user sql: recs: ~s~n",[FetchUserSQL]),
     FetchUserResult = emysql:execute(pushdice_pool, FetchUserSQL),
     Recs = emysql_util:as_record(FetchUserResult, game_user, record_info(fields, game_user)),
     io:format("fetch user by session: recs: ~w~n",[Recs]),

     case Recs of 
         [{game_user,UserId,UserName,UserPlatId,UserPlatType,{datetime,{{UserLastPlayYr,UserLastPlayM,UserLastPlayDay},{UserLastPlayHr,UserLastPlayMin,UserLastPlaySec}}},UserConsecDaysPlayed,UserIsUnlocked,UserCoins}] ->
             UserInfoJson =  [{user_id,UserId},{name,UserName},{plat_id,UserPlatId},{plat_type,UserPlatType},{coins,UserCoins},{unlock,UserIsUnlocked}],
             UserInfoJsonStr = mochijson2:encode({struct, UserInfoJson}),
             {html, UserInfoJsonStr};
          true ->
             {html, "{'code':'-1', 'msg':'Fail to get user data from session.'}"}
      end.
%% out(Arg, [Fbusername]) -> 
%%     inets:start(),
%%     {ok, {{Version, 200, ReasonPhrase}, Headers, Body}} = httpc:request("http://www.erlang.org"),
%%     {html, Body}.
