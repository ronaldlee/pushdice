-module(usermodel).
-export([getUser/2]).
-export([createUser/6]).
-export([getUserByPlatID/3]).
-export([getUserByUsernameAndPlatID/4]).
-export([incrementLastPlayAndConsecDaysPlayed/2]).
-export([resetLastPlayAndConsecDaysPlayed/2]).
-export([updateIOSPushToken/3]).
-export([getUserSessionData/1]).
-export([incrementCoins/3]).
-export([deductCoins/3]).
-export([getRandomPlayers/3]).


-record(game_user, {user_id, name, plat_id, plat_type,last_play_date,consecutive_days_played,is_unlocked,coins}).

getUser(DB_pool,UID) ->
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE user_id='~s'",[UID]),
  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)).

createUser(DB_pool,Username,PlatID,PlatType,AccessToken,IOSPushToken) ->
  InsertSql = io_lib:format("INSERT INTO user (name,plat_id,plat_type,fb_accesstoken,ios_push_token,consecutive_days_played,coins,last_play_date) values ('~s','~s','~s','~s','~s','1','1000',NULL) ON DUPLICATE KEY UPDATE name='~s', fb_accesstoken='~s', ios_push_token='~s', consecutive_days_played=consecutive_days_played+1, last_play_date=NULL",[Username,PlatID,PlatType,AccessToken,IOSPushToken,Username,AccessToken,IOSPushToken]),
  emysql:execute(DB_pool, InsertSql).


getUserByPlatID(DB_pool,PlatID,PlatType) ->
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE plat_id='~s' and plat_type='~s'",[PlatID,PlatType]),
  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)).

getUserByUsernameAndPlatID(DB_pool,Username,PlatID,PlatType) ->
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE name='~s' and plat_id='~s' and plat_type='~s'",[Username,PlatID,PlatType]),
  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)).

incrementCoins(DB_pool,UID,Coins) ->
  UpdateCoinsSQL = io_lib:format("Update user set coins=coins+~s WHERE user_id='~s'",[Coins,UID]),
  emysql:execute(DB_pool, UpdateCoinsSQL).

deductCoins(DB_pool,UID,Coins) ->
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE user_id='~s'",[UID]),
  SelectResult = emysql:execute(DB_pool, SelectSQL),
  Recs = emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)),

  SelectLength = length(Recs),

  case SelectLength of 
    1->
      %[{game_user,FoundUserId,FoundUsername,FoundPlatId,FoundPlatType,
      %{datetime,{{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}},
      %ConsecDaysPlayed,IsUnlocked,FoundCoins} | _ ] = Recs,

      [{game_user,_,_,_,_,_,_,_,FoundCoins} | _ ] = Recs,
io:format("hasEnoughCoins FoundCoins: ~w, Coins: ~w ~n",[FoundCoins,Coins]),
      if 
        FoundCoins >= Coins ->
io:format("hasEnoughCoins has enough~n"),
          DeductSQL = io_lib:format("UPDATE user set coins=coins-~s WHERE user_id='~s'",[integer_to_list(Coins),UID]),
io:format("hasEnoughCoins sql: ~s~n",[DeductSQL]),
          emysql:execute(DB_pool, DeductSQL),
          true;
        true -> 
io:format("hasEnoughCoins NOT enough~n"),
          false
      end;
    _->
      false
  end.

incrementLastPlayAndConsecDaysPlayed(DB_pool,UID) ->
  UpdateConsecDaysPlayedSQL = io_lib:format("Update user set last_play_date=NULL,consecutive_days_played=consecutive_days_played+1 WHERE user_id='~s'",[UID]),
  emysql:execute(DB_pool, UpdateConsecDaysPlayedSQL).

resetLastPlayAndConsecDaysPlayed(DB_pool,UID) ->
  UpdateConsecDaysPlayedSQL = io_lib:format("Update user set last_play_date=NULL,consecutive_days_played=1 WHERE user_id='~s'",[UID]),
  emysql:execute(DB_pool, UpdateConsecDaysPlayedSQL).

updateIOSPushToken(DB_pool,UID,IOSPushToken) ->
  UpdateSQL = io_lib:format("Update user set ios_push_token='~s' WHERE user_id='~s'",[IOSPushToken,UID]),
  emysql:execute(DB_pool, UpdateSQL).

getUserSessionData(Session) ->
 FetchUserSessionCacheKey = string:concat("pd_session_",Session),
io:format("get user session key: ~s ~n",[FetchUserSessionCacheKey]),
 FetchUserBinData = erlmc:get(FetchUserSessionCacheKey),
io:format("get user session data: ~w ~n",[FetchUserBinData]),
 binary_to_term(FetchUserBinData).

getRandomPlayers(DB_pool,UID,NumPlayers) ->
  RandomPlayers = io_lib:format("select * from user where user_id != ~s order by rand() limit ~s",[UID,NumPlayers]),
  io:format("getRandomPlayers: ~s ~n",[RandomPlayers]),
  Data = emysql:execute(DB_pool, RandomPlayers),
  emysql_util:as_record(Data, game_user, record_info(fields, game_user)).

