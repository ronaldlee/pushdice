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
        {check, FromPid} -> 
            FromPid ! "init";
        {join, Player2_uid} ->
            io:format("join. ~s~n",[Player2_uid]),
            wait_for_p1_rolldice();
        {_ , Player2_uid} -> 
            io:format("player 2 can only join. ~n",[]),
            {error,'player 2 can only join.'}
    end.

wait_for_p1_rolldice() ->
    receive
        {check, FromPid} -> 
            FromPid ! "p1_roll";
        {p1_roll,Player1_uid,buy_in, BuyIn, FromPid} ->
        %check if p1 has enough to make the blind first
            io:format("p1 roll dice ~n",[]),
            random:seed(now()),
            Dice1_value = random:uniform(6),
            Dice2_value = random:uniform(6),
            Dice3_value = random:uniform(6),
            Dice4_value = random:uniform(6),
            Dice5_value = random:uniform(6),

            %sort the dice from low to high
            [SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value] = lists:sort([Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value]),

            io:format("p1 roll dice: ~w,~w,~w,~w,~w ~n",[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value]),
            FromPid ! {dice_result,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value},
            wait_for_p1_makecall(SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,BuyIn)
    end.

wait_for_p1_makecall(SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn) ->
    receive
        {check, FromPid} -> 
            FromPid ! "p1_makecall";
        {p1_call,Player1_uid,FromPid,P1Dice1,P1Dice2,P1Dice3,P1Dice4,P1Dice5,p1_raise,P1Raise} ->
            io:format("make call aaa~n",[]),
            Player1_uid,
            %ConvertFun = fun({X,Y}) -> {X,list_to_binary(Y)} end,
            %DiceCombConverted = lists:map(ConvertFun, DiceComb),
            %SortedCallDice = lists:sort(DiceCombConverted),

            SortedCallDice = lists:sort([P1Dice1,P1Dice2,P1Dice3,P1Dice4,P1Dice5]),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Need to check if the call is valid!!!  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
io:format("make call ~s~n",[[50]]),
io:format("make call ~w~n",[{P1Dice1,P1Dice2,P1Dice3,P1Dice4,P1Dice5}]),
            %P1Dice_int = io_lib:format('~s',[P1Dice1]),
            %P2Dice_int = io_lib:format('~s',[P1Dice2]),
            %P3Dice_int = io_lib:format('~s',[P1Dice3]),
            %P4Dice_int = io_lib:format('~s',[P1Dice4]),
            %P5Dice_int = io_lib:format('~s',[P1Dice5]),
%io:format("make call a ~w~n",[{P1Dice_int,P2Dice_int,P3Dice_int,P4Dice_int,P5Dice_int}]),
            %IsValid = case {P1Dice_int,P2Dice_int,P3Dice_int,P4Dice_int,P5Dice_int} of 
            IsValid = case {P1Dice1,P1Dice2,P1Dice3,P1Dice4,P1Dice5} of 
                {"1","2","3","4","5"} -> io:format("match 1 ~n",[]), true;
                {"2","3","4","5","6"} -> io:format("match 2 ~n",[]), true;
                {"1","1","1","1","1"} -> io:format("match 3 ~n",[]), true;
                {"2","2","2","2","2"} -> io:format("match 4 ~n",[]), true;
                {"3","3","3","3","3"} -> io:format("match 5 ~n",[]), true;
                {"4","4","4","4","4"} -> io:format("match 6 ~n",[]), true;
                {"5","5","5","5","5"} -> io:format("match 7 ~n",[]), true;
                {"6","6","6","6","6"} -> io:format("match 8 ~n",[]), true;
                {"1","1","1","1",_} -> io:format("match 11~n",[]), true;
                {"2","2","2","2",_} -> io:format("match 12~n",[]), true;
                {"3","3","3","3",_} -> io:format("match 13~n",[]), true;
                {"4","4","4","4",_} -> io:format("match 14~n",[]), true;
                {"5","5","5","5",_} -> io:format("match 15~n",[]), true;
                {"6","6","6","6",_} -> io:format("match 16~n",[]), true;

                {"1","1","2","2",_} -> io:format("match 17~n",[]), true;
                {"1","1","3","3",_} -> io:format("match 18~n",[]), true;
                {"1","1","4","4",_} -> io:format("match 19~n",[]), true;
                {"1","1","5","5",_} -> io:format("match 21~n",[]), true;
                {"1","1","6","6",_} -> io:format("match 22~n",[]), true;
                {"2","2","3","3",_} -> io:format("match 23~n",[]), true;
                {"2","2","4","4",_} -> io:format("match 24~n",[]), true;
                {"2","2","5","5",_} -> io:format("match 25~n",[]), true;
                {"2","2","6","6",_} -> io:format("match 26~n",[]), true;
                {"3","3","4","4",_} -> io:format("match 27~n",[]), true;
                {"3","3","5","5",_} -> io:format("match 28~n",[]), true;
                {"3","3","6","6",_} -> io:format("match 29~n",[]), true;
                {"4","4","5","5",_} -> io:format("match 31~n",[]), true;
                {"4","4","6","6",_} -> io:format("match 32~n",[]), true;
                {"5","5","6","6",_} -> io:format("match 33~n",[]), true;

                {"1","1","1",_,_} -> io:format("match 34~n",[]), true;
                {"2","2","2",_,_} -> io:format("match 35~n",[]), true;
                {"3","3","3",_,_} -> io:format("match 36~n",[]), true;
                {"4","4","4",_,_} -> io:format("match 37~n",[]), true;
                {"5","5","5",_,_} -> io:format("match 38~n",[]), true;
                {"6","6","6",_,_} -> io:format("match 39~n",[]), true;

                {"1","1",_,_,_} -> io:format("match 41~n",[]), true;
                {"2","2",_,_,_} -> io:format("match 42~n",[]), true;
                {"3","3",_,_,_} -> io:format("match 43~n",[]), true;
                {"4","4",_,_,_} -> io:format("match 44~n",[]), true;
                {"5","5",_,_,_} -> io:format("match 45~n",[]), true;
                {"6","6",_,_,_} -> io:format("match 46~n",[]), true;

                _ -> false
            end,

            case IsValid of 
                true ->
                    FromPid ! valid_call,
                    wait_for_p2_findcall(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise);
                    %wait_for_p1_makecall(SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value);
                false ->
                    %loop back
                    FromPid ! invalid_call,
                    wait_for_p1_makecall(SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn)
            end;
        _ -> 
            io:format("whatt!! ~n",[])
            
    end.

wait_for_p2_findcall(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise) ->
    io:format("p2 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! "p2_findcall";
        {p2_findcall,Player2_uid,FromPid} ->
            %return p1 actual dice combination
            FromPid ! {"p1_calldice", SortedCallDice, "p1_buyin",P1BuyIn, "p1_raise",P1Raise},
            wait_for_p2_trust_or_not(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise)
    end.


wait_for_p2_trust_or_not(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise) ->
io:format("p2 trust or not! ~n"),
    receive
        {check, FromPid} -> 
            FromPid ! "p2_trust_not";
        {trust,Player2_uid,FromPid,bet,P2Bet} ->
io:format("trust! ~w, ~w ~n",[P1BuyIn,P1Raise]),
            %check if p2 bet matches p1's, if not return error
            P1TotalBet = P1BuyIn + P1Raise,
io:format("trust 2! ~w ~n",[P1TotalBet]),
            if 
                (P2Bet < P1TotalBet) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! "p2_bad_bet";
                true ->
                    io:format("p2 valid bet! ~n"),
                    %else return p1's actual dice
                    FromPid ! {p1_dice,SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise},
                    wait_for_p2_pick_dice_to_roll(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise,P2Bet)
            end;
        {not_trust,Player2_uid,FromPid} ->
            %if p1 actual result not match the dice comb call by p1, p2 win. else p2 lose
            true
    end.


wait_for_p2_pick_dice_to_roll(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise,P2Bet) ->
true.


join_gameroom(Pid,Player2_uid) ->
    Pid ! {join, Player2_uid}.

player1_rolldice(Pid,Player1_uid,BuyIn) -> 
    Pid ! {p1_roll,Player1_uid,buy_in, list_to_integer(BuyIn), self()}.

player1_makecall(Pid,Player1_uid,D1,D2,D3,D4,D5,P1Raise) -> 
    Pid ! {p1_call,Player1_uid,self(),D1,D2,D3,D4,D5,p1_raise,list_to_integer(P1Raise)},
    receive
        valid_call -> valid_call;
        invalid_call -> invalid_call
    end.

player2_findcall(Pid,Player2_uid) -> 
    Pid ! {p2_findcall,Player2_uid,self()}.

player2_trustcall(Pid,Player2_uid,P2Bet) ->
    Pid ! {trust,Player2_uid,self(),bet,P2Bet}.

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

out(Arg, ["rolldice", "room_pid", Pid, "p1_uid", Player1_uid,"buy_in", BuyIn]) -> 
    io:format("!rolldice. ~n",[]),
    player1_rolldice(list_to_pid(Pid),Player1_uid,BuyIn),
    receive
        {dice_result,Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value} ->
            %build dice result json.
            DiceResultJson = {dice_result,[Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value]},
            DiceResultJsonStr = mochijson2:encode({struct, [DiceResultJson]}),
            {html, DiceResultJsonStr}
    end;

out(Arg, ["makecall", "room_pid", Pid, "p1_uid", Player1_uid,"call",D1,D2,D3,D4,D5,"raise",P1Raise]) -> 
    io:format("p1 make call. ~n",[]),
    [SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value] = lists:sort([D1,D2,D3,D4,D5]),
    ValidCall = player1_makecall(list_to_pid(Pid),Player1_uid,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1Raise),
    Response = [ {code,ValidCall}  ],
    Output = mochijson2:encode({struct, Response}),
    {html, Output};

out(Arg, ["check", "room_pid", Pid]) -> 
    io:format("check room. ~n",[]),
    list_to_pid(Pid) ! {'check',self()},
    RoomState = receive
        State -> State
    end,
    Response = [ {code,0}, {room_state,list_to_binary(RoomState)} ],
    Output = mochijson2:encode({struct, Response}),
    {html, Output};

out(Arg, ["get_p1_call", "room_pid", Pid, "p2_uid", Player2_uid]) -> 
    io:format("p2 find out p1 call. ~n",[]),
    player2_findcall(list_to_pid(Pid),Player2_uid),
    receive
        {"p1_calldice", SortedCallDice, "p1_buyin", P1BuyIn, "p1_raise", P1Raise} ->
io:format("SortedCallDice: p1_raise: ~s, buyin: ~s~n",[P1Raise,P1BuyIn]),
io:format("SortedCallDice: ~w~n",[SortedCallDice]),
            %ConvertFun = fun([X]) -> list_to_binary([X]) end,
            ConvertFun = fun([X]) -> list_to_integer([X]) end,
            CallDiceConverted = lists:map(ConvertFun, SortedCallDice),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{p1_call,CallDiceConverted},{p1_buyin,list_to_integer(P1BuyIn)},{p1_raise,list_to_integer(P1Raise)}]}),
io:format("P1DiceResultJsonStr: ~s~n",[P1DiceResultJsonStr]),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, ["p2_trust", "room_pid", Pid, "p2_uid", Player2_uid, "p2_bet",P2Bet]) -> 
    io:format("p2 trust. ~n",[]),
    player2_trustcall(list_to_pid(Pid),Player2_uid,P2Bet),
    receive
        {p1_dice,SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise} ->
io:format("p2 trust get actual p1 call~n"),
            ConvertFun = fun([X]) -> list_to_integer([X]) end,
            CallDiceConverted = lists:map(ConvertFun, SortedCallDice),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{p1_call,CallDiceConverted},{p1_actual,[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value]},{p1_buyin,P1BuyIn},{p1_raise,P1Raise}]}),
            {html, P1DiceResultJsonStr}
    end.
