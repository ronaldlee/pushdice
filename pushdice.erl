-module(pushdice).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).

-record(game_user, {user_id, name, plat_id, plat_type,last_play_date,consecutive_days_played,is_unlocked}).

-define(ONE_DAY_SECS,86400).
-define(TWO_DAY_SECS,172800).

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

     SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked from user WHERE name='~s' and plat_id='~s' and plat_type='~s'",[Username,Id,Type]),
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
         [{game_user,NewUserId,FoundUsername,FoundId,FoundType,{datetime,{{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}},
             ConsecDaysPlayed,IsUnlocked} | _ ] = Recs,

         LastPlayTime = calendar:datetime_to_gregorian_seconds({{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}),

         LocalTime = calendar:datetime_to_gregorian_seconds(erlang:localtime()),

         TimeDiff = LocalTime-LastPlayTime,

         %if last play time is greater than 1 day and less than 2 days -> consecutive days
         if ((TimeDiff > ?ONE_DAY_SECS) and (TimeDiff < ?TWO_DAY_SECS)) ->
             UpdateConsecDaysPlayedSQL = io_lib:format("Update user set last_play_date=NULL,consecutive_days_played=consecutive_days_played+1 WHERE user_id='~w'",[NewUserId]),
             UpdateConsecDaysPlayedResult = emysql:execute(pushdice_pool, UpdateConsecDaysPlayedSQL);
             true ->
             io:format("not consec play ~n",[]),
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

     UserData = {{user_id,NewUserId},{name,Username},{plat_id,Id},{plat_type,Type}},
     io:format("user data ~w~n",[UserData]),
     UserSessionCacheKey = string:concat("pd_session_",SessionId),
     erlmc:set(UserSessionCacheKey,term_to_binary(UserData),60),

     SessionJson= mochijson2:encode({struct, [{session,list_to_binary(SessionId)}]}),
     {html, SessionJson};
out(Arg, ["login", "username", Username, "id", Id, "type", Type]) -> 
     out(Arg,["login", "username", Username, "id", Id, "type", Type, "accesstoken", ""]);
out(Arg, ["user", "session", Session]) -> 
     %get user info from session
 
     {html, 'ok'};
out(Arg, [Fbusername]) -> 
     inets:start(),
     {ok, {{Version, 200, ReasonPhrase}, Headers, Body}} = httpc:request("http://www.erlang.org"),
     {html, Body};
out(Arg, ["game", "start", "uid", Uid, "friend_uid", Friend_uid]) -> 
     io:format("mysqlllll ~n",[]),
     crypto:start(),
     io:format("mysqlllll 1 ~n",[]),
     application:start(emysql),
     io:format("mysqlllll 2 ~n",[]),

%%      emysql:add_pool(pushdice_pool, 1,
%%          "root", "jackassdummy", "localhost", 3306,
%%          "pushdice", utf8),

     Status = try (emysql:add_pool(pushdice_pool, 1, "root", "jackassdummy", "localhost", 3306, "pushdice", utf8)) of 
         Val -> 0
     catch
         %% _:_ -> -1
%%          Throw:_-> 
%%              io:format("throw error boo ~w~n",[Throw]),
%%              {throw,error}
         exit:pool_already_exists -> 
             io:format("throw error already exist ~n",[]),
             1
     end,

     %% execute when Status is 0 or 1
     %% io:format("mysqlllll 3: status: ~w~n",[Status]),
     io:format("mysqlllll 3: status: ~n",[]),
     emysql:execute(pushdice_pool,
         <<"INSERT INTO user (name,coins) values ('ronald',11)">>),
     io:format("mysqlllll 4 ~n",[]),

     Result = emysql:execute(pushdice_pool,
         <<"select * from user">>),
     io:format("mysqlllll 5 ~n",[]),

     io:format("~n~p~n", [Result]),
     {html, Friend_uid}.

