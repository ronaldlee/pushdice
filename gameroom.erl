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
        %check if p1 has enough to make the blind first

        io:format("p1 roll dice ~n",[]),
        Dice1_value = random:uniform(6),
        Dice2_value = random:uniform(6),
        Dice3_value = random:uniform(6),
        Dice4_value = random:uniform(6),
        Dice5_value = random:uniform(6),

        %sort the dice from low to high
        [SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value] = lists:sort([Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value]),

        io:format("p1 roll dice: ~w,~w,~w,~w,~w ~n",[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value]),
        FromPid ! {dice_result,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value},
        wait_for_p1_makecall(SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value)
    end.

wait_for_p1_makecall(SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value) ->
    DiceComb = receive
        {p1_call,Player1_uid,FromPid,DiceCall} ->
            DiceCall
%        {p1_call,Player1_uid,FromPid,1,2,3,4,5} ->
%            {1,2,3,4,5};
%        {p1_call,Player1_uid,FromPid,2,3,4,5,6} ->
%            {2,3,4,5,6};
%
%        {p1_call,Player1_uid,FromPid,1,1,1,1,1} ->
%            {1,1,1,1,1};
%        {p1_call,Player1_uid,FromPid,2,2,2,2,2} ->
%            {2,2,2,2,2};
%        {p1_call,Player1_uid,FromPid,3,3,3,3,3} ->
%            5;
%        {p1_call,Player1_uid,FromPid,4,4,4,4,4} ->
%            6;
%        {p1_call,Player1_uid,FromPid,5,5,5,5,5} ->
%            7;
%        {p1_call,Player1_uid,FromPid,6,6,6,6,6} ->
%            8;
%
%        {p1_call,Player1_uid,FromPid,1,1,1,1,_} ->
%            9;
%        {p1_call,Player1_uid,FromPid,2,2,2,2,_} ->
%            10;
%        {p1_call,Player1_uid,FromPid,3,3,3,3,_} ->
%            11;
%        {p1_call,Player1_uid,FromPid,4,4,4,4,_} ->
%            12;
%        {p1_call,Player1_uid,FromPid,5,5,5,5,_} ->
%            13;
%        {p1_call,Player1_uid,FromPid,6,6,6,6,_} ->
%            14;
%
%        {p1_call,Player1_uid,FromPid,1,1,2,2,_} ->
%            15;
%        {p1_call,Player1_uid,FromPid,1,1,3,3,_} ->
%            16;
%        {p1_call,Player1_uid,FromPid,1,1,4,4,_} ->
%            17;
%        {p1_call,Player1_uid,FromPid,1,1,5,5,_} ->
%            18;
%        {p1_call,Player1_uid,FromPid,1,1,6,6,_} ->
%            19;
%        {p1_call,Player1_uid,FromPid,2,2,3,3,_} ->
%            20;
%        {p1_call,Player1_uid,FromPid,2,2,4,4,_} ->
%            21;
%        {p1_call,Player1_uid,FromPid,2,2,5,5,_} ->
%            22;
%        {p1_call,Player1_uid,FromPid,2,2,6,6,_} ->
%            23;
%        {p1_call,Player1_uid,FromPid,3,3,4,4,_} ->
%            24;
%        {p1_call,Player1_uid,FromPid,3,3,5,5,_} ->
%            25;
%        {p1_call,Player1_uid,FromPid,3,3,6,6,_} ->
%            26;
%        {p1_call,Player1_uid,FromPid,4,4,5,5,_} ->
%            27;
%        {p1_call,Player1_uid,FromPid,4,4,6,6,_} ->
%            28;
%        {p1_call,Player1_uid,FromPid,5,5,6,6,_} ->
%            29;
%
%        {p1_call,Player1_uid,FromPid,1,1,1,_,_} ->
%            30;
%        {p1_call,Player1_uid,FromPid,2,2,2,_,_} ->
%            31;
%        {p1_call,Player1_uid,FromPid,3,3,3,_,_} ->
%            32;
%        {p1_call,Player1_uid,FromPid,4,4,4,_,_} ->
%            33;
%        {p1_call,Player1_uid,FromPid,5,5,5,_,_} ->
%            34;
%        {p1_call,Player1_uid,FromPid,6,6,6,_,_} ->
%            35;
%
%        {p1_call,Player1_uid,FromPid,1,1,_,_,_} ->
%            36;
%        {p1_call,Player1_uid,FromPid,2,2,_,_,_} ->
%            37;
%        {p1_call,Player1_uid,FromPid,3,3,_,_,_} ->
%            38;
%        {p1_call,Player1_uid,FromPid,4,4,_,_,_} ->
%            39;
%        {p1_call,Player1_uid,FromPid,5,5,_,_,_} ->
%            40;
%        {p1_call,Player1_uid,FromPid,6,6,_,_,_} ->
%            41
    end,
    Player1_uid,
    FromPid,
    SortedDiceComb = lists:sort(DiceComb),
    wait_for_p2_findcall(SortedDiceComb,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value),
    io:format("make call p1 dice: dicecomb: ~w, actual: ~w,~w,~w,~w,~w ~n",[SortedDiceComb,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value]).

wait_for_p2_findcall(DiceComb,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value) ->
    receive
        {p2_findcall,Player2_uid,FromPid} ->
            %return p1 actual dice combination
            FromPid ! {"p1_actualdice", SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value},
            wait_for_p2_trust_or_not(DiceComb,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value)
    end.


wait_for_p2_trust_or_not(DiceComb,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value) ->
    receive
        {trust,Player2_uid,FromPid} ->
            %player 2 look at dice
            true;
        {not_trust,Player2_uid,FromPid} ->
            %if p1 actual result not match the dice comb call by p1, p2 win. else p2 lose
            true
    end.

join_gameroom(Pid,Player2_uid) ->
    Pid ! {join, Player2_uid}.

player1_rolldice(Pid,Player1_uid) -> 
    Pid ! {p1_roll,Player1_uid,self()}.

player1_makecall(Pid,Player1_uid,D1,D2,D3,D4,D5) -> 
    Pid ! {p1_call,Player1_uid,self(),[D1,D2,D3,D4,D5]}.

player2_findcall(Pid,Player2_uid) -> 
    Pid ! {p2_findcall,Player2_uid,self()}.

%%%%%%%%%%%%%%%%%%%%%%%%%%
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
            DiceResultJson = {dice_result,[Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value]},
            DiceResultJsonStr = mochijson2:encode({struct, [DiceResultJson]}),
            {html, DiceResultJsonStr}
    end;

out(Arg, ["makecall", "room_pid", Pid, "p1_uid", Player1_uid,"call",D1,D2,D3,D4,D5]) -> 
    io:format("p1 make call. ~n",[]),
    [SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value] = lists:sort([D1,D2,D3,D4,D5]),
    player1_makecall(list_to_pid(Pid),Player1_uid,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value),
    receive
        _ ->
        {html, "ok"}
    end;

out(Arg, ["getP1Call", "room_pid", Pid, "p2_uid", Player2_uid]) -> 
    io:format("p2 find out p1 call. ~n",[]),
    player2_findcall(list_to_pid(Pid),Player2_uid),
    receive
        {"p1_actualdice", SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value} ->
            P1DiceResultJson = {dice_result,[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value]},
            P1DiceResultJsonStr = mochijson2:encode({struct, [P1DiceResultJson]}),
            {html, P1DiceResultJsonStr}
    end.
