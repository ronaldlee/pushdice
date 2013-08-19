-module(gameroom).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).

start(Player1_uid,Player2_uid) ->
    io:format("start. ~n",[]),
    Pid = spawn(gameroom, init_gameroom, [Player1_uid,Player2_uid]),
    %need monitor the game room!
    io:format("start: pid: ~w~n",[Pid]),
    %% register(gameroom_proc, Pid),
    io:format("start. ~n",[]),
    Pid.

init_gameroom(Player1_uid,Player2_uid) ->
    receive
        {join, Player2_uid} ->
        io:format("join. ~s~n",[Player2_uid]),
        wait_for_p1_rolldice();
        {_ , Player2_uid} -> 
            io:format("player 2 can only join. ~n",[]),
            {error,'player 2 can only join.'}
    end.

wait_for_p1_rolldice() ->
    receive
        {p1_roll,Player1_uid,FromPid} ->
        io:format("p1 roll dice ~n",[]),
        Dice1_value = random:uniform(6),
        Dice2_value = random:uniform(6),
        Dice3_value = random:uniform(6),
        Dice4_value = random:uniform(6),
        Dice5_value = random:uniform(6),
        io:format("p1 roll dice: ~w,~w,~w,~w,~w ~n",[Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value]),
        FromPid ! {dice_result,Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value},
        %wait_for_p1_makecall()
        wait_for_p1_rolldice()
    end.

wait_for_p1_makecall() ->
    receive
        {p1_bet,Player1_uid,PlayerBetAmound,FromPid} ->
            true
    end.

join_gameroom(Pid,Player2_uid) ->
    Pid ! {join, Player2_uid}.

player1_rolldice(Pid,Player1_uid) -> 
    io:format("roll dice. ~n",[]),
    Pid ! {p1_roll,Player1_uid,self()}.

out(Arg) ->
    io:format("main. ~n",[]),
    Uri = yaws_api:request_url(Arg),
    [Path|Rest] = string:tokens(Uri#url.path, "/"),
    Method = (Arg#arg.req)#http_request.method,
    out(Arg,Rest).

out(Arg, ["init", "p1_uid", Player1_uid, "p2_uid", Player2_uid]) -> 
    io:format("init. ~n",[]),
    NewPid = start(Player1_uid,Player2_uid),
    Response = [ {code,"2"}, {pid,pid_to_list(NewPid)} ],
    ConvertFun = fun({X,Y}) -> {X,list_to_binary(Y)} end,
    StringConverted = lists:map(ConvertFun, Response),
    Output = mochijson2:encode({struct, StringConverted}),
    {html, Output};

out(Arg, ["join", "room_pid", Pid, "uid", Player2_uid]) -> 
    io:format("join. ~w~n",[list_to_pid(Pid)]),
    join_gameroom(list_to_pid(Pid), Player2_uid),
    {html, Player2_uid};

out(Arg, ["rolldice", "room_pid", Pid, "p1_uid", Player1_uid]) -> 
    io:format("!rolldice. ~n",[]),
    player1_rolldice(list_to_pid(Pid),Player1_uid),
    receive
        {dice_result,Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value} ->
        %build dice result json.
    io:format("receive dice result. ~n",[]),
        DiceResultJson = {dice_result,[Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value]},
        DiceResultJsonStr = mochijson2:encode({struct, [DiceResultJson]}),
        {html, DiceResultJsonStr}
    end.

