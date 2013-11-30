-module(itemmodel).
-export([getItemPropByType/2]).
-export([getItemPropByTypeAndName/3]).

-record(item_prop, {item_prop_name, item_prop_value}).

getItemPropByType(DB_pool,Type) ->
  SelectSQL = io_lib:format("SELECT item_prop.name as item_prop_name, item_prop.value as item_prop_value from item join item_prop on item.item_id = item_prop.item_id WHERE item.type='~w'",[Type]),

  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, item_prop, record_info(fields, item_prop)).

getItemPropByTypeAndName(DB_pool,Type,Name) ->
io:format("getItemPropByTypeAndName~n"),
  SelectSQL = io_lib:format("SELECT item_prop.name as item_prop_name, item_prop.value as item_prop_value from item join item_prop on item.item_id = item_prop.item_id WHERE item.type='~w' and item_prop.name='~s'",[Type,Name]),

io:format("inapp sql: ~s~n",[SelectSQL]),

  SelectResult = emysql:execute(DB_pool, SelectSQL),
  emysql_util:as_record(SelectResult, item_prop, record_info(fields, item_prop)).
