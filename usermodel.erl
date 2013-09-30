-module(usermodel).
-export([getUser/2]).
-export([createUser/5]).
-export([getUserByPlatID/3]).
-export([getUserByUsernameAndPlatID/4]).
-export([incrementLastPlayAndConsecDaysPlayed/2]).
-export([resetLastPlayAndConsecDaysPlayed/2]).


-record(game_user, {user_id, name, plat_id, plat_type,last_play_date,consecutive_days_played,is_unlocked,coins}).

getUser(DB_pool,UID) ->
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE user_id='~s'",[UID]),
  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)).

createUser(DB_pool,Username,PlatID,PlatType,AccessToken) ->
  InsertSql = io_lib:format("INSERT INTO user (name,plat_id,plat_type,fb_accesstoken,consecutive_days_played,coins,last_play_date) values ('~s','~s','~s','~s','1','1000',NULL)",[Username,PlatID,PlatType,AccessToken]),
  emysql:execute(DB_pool, InsertSql).


getUserByPlatID(DB_pool,PlatID,PlatType) ->
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE plat_id='~s' and plat_type='~s'",[PlatID,PlatType]),
  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)).

getUserByUsernameAndPlatID(DB_pool,Username,PlatID,PlatType) ->
  SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE name='~s' and plat_id='~s' and plat_type='~s'",[Username,PlatID,PlatType]),
  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)).


incrementLastPlayAndConsecDaysPlayed(DB_pool,UID) ->
  UpdateConsecDaysPlayedSQL = io_lib:format("Update user set last_play_date=NULL,consecutive_days_played=consecutive_days_played+1 WHERE user_id='~s'",[UID]),
  emysql:execute(DB_pool, UpdateConsecDaysPlayedSQL).

resetLastPlayAndConsecDaysPlayed(DB_pool,UID) ->
  UpdateConsecDaysPlayedSQL = io_lib:format("Update user set last_play_date=NULL,consecutive_days_played=1 WHERE user_id='~s'",[UID]),
  emysql:execute(DB_pool, UpdateConsecDaysPlayedSQL).
