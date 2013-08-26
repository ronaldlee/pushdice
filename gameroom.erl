-module(gameroom).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).

getDiceScore(DiceList) ->
io:format("get score int dice list: ~w~n",[DiceList]),
    case DiceList of 
	%{"1","2","3","4","5"} -> io:format("match 1 ~n",[]), true;
	%{"2","3","4","5","6"} -> io:format("match 2 ~n",[]), true;

	[1,1,1,1,1] -> io:format("match 3 ~n",[]), 79;
	[6,6,6,6,6] -> io:format("match 8 ~n",[]), 78;
	[5,5,5,5,5] -> io:format("match 7 ~n",[]), 77;
	[4,4,4,4,4] -> io:format("match 6 ~n",[]), 76;
	[3,3,3,3,3] -> io:format("match 5 ~n",[]), 75;
	[2,2,2,2,2] -> io:format("match 4 ~n",[]), 74;

	[1,1,1,1,_] -> io:format("match 11~n",[]), 73;
	[6,6,6,6,_] -> io:format("match 16~n",[]), 72;
	[5,5,5,5,_] -> io:format("match 15~n",[]), 71;
	[4,4,4,4,_] -> io:format("match 14~n",[]), 70;
	[3,3,3,3,_] -> io:format("match 13~n",[]), 69;
	[2,2,2,2,_] -> io:format("match 12~n",[]), 68;

	[1,1,1,6,6] -> io:format("match 3 ~n",[]), 67;
	[1,1,1,5,5] -> io:format("match 3 ~n",[]), 66;
	[1,1,1,4,4] -> io:format("match 3 ~n",[]), 65;
	[1,1,1,3,3] -> io:format("match 3 ~n",[]), 64;
	[1,1,1,2,2] -> io:format("match 3 ~n",[]), 63;

	[2,2,2,1,1] -> io:format("match 3 ~n",[]), 62;
	[2,2,2,6,6] -> io:format("match 3 ~n",[]), 61;
	[2,2,2,5,5] -> io:format("match 3 ~n",[]), 60;
	[2,2,2,4,4] -> io:format("match 3 ~n",[]), 59;
	[2,2,2,3,3] -> io:format("match 3 ~n",[]), 58;

	[3,3,3,1,1] -> io:format("match 3 ~n",[]), 57;
	[3,3,3,6,6] -> io:format("match 3 ~n",[]), 56;
	[3,3,3,5,5] -> io:format("match 3 ~n",[]), 55;
	[3,3,3,4,4] -> io:format("match 3 ~n",[]), 54;
	[3,3,3,2,2] -> io:format("match 3 ~n",[]), 53;

	[4,4,4,1,1] -> io:format("match 3 ~n",[]), 52;
	[4,4,4,6,6] -> io:format("match 3 ~n",[]), 51;
	[4,4,4,5,5] -> io:format("match 3 ~n",[]), 50;
	[4,4,4,3,3] -> io:format("match 3 ~n",[]), 49;
	[4,4,4,2,2] -> io:format("match 3 ~n",[]), 48;

	[5,5,5,1,1] -> io:format("match 3 ~n",[]), 47;
	[5,5,5,6,6] -> io:format("match 3 ~n",[]), 46;
	[5,5,5,4,4] -> io:format("match 3 ~n",[]), 45;
	[5,5,5,3,3] -> io:format("match 3 ~n",[]), 44;
	[5,5,5,2,2] -> io:format("match 3 ~n",[]), 43;

	[6,6,6,1,1] -> io:format("match 3 ~n",[]), 42;
	[6,6,6,5,5] -> io:format("match 3 ~n",[]), 41;
	[6,6,6,4,4] -> io:format("match 3 ~n",[]), 40;
	[6,6,6,3,3] -> io:format("match 3 ~n",[]), 39;
	[6,6,6,2,2] -> io:format("match 3 ~n",[]), 38;

	[1,1,6,6,_] -> io:format("match 22~n",[]), 37;
	[1,1,5,5,_] -> io:format("match 21~n",[]), 36;
	[1,1,4,4,_] -> io:format("match 19~n",[]), 35;
	[1,1,3,3,_] -> io:format("match 18~n",[]), 34;
	[1,1,2,2,_] -> io:format("match 17~n",[]), 33;

	[2,2,1,1,_] -> io:format("match 23~n",[]), 32;
	[2,2,6,6,_] -> io:format("match 26~n",[]), 31;
	[2,2,5,5,_] -> io:format("match 25~n",[]), 30;
	[2,2,4,4,_] -> io:format("match 24~n",[]), 29;
	[2,2,3,3,_] -> io:format("match 23~n",[]), 28;

	[3,3,1,1,_] -> io:format("match 27~n",[]), 27;
	[3,3,6,6,_] -> io:format("match 29~n",[]), 26;
	[3,3,5,5,_] -> io:format("match 28~n",[]), 25;
	[3,3,4,4,_] -> io:format("match 27~n",[]), 24;
	[3,3,2,2,_] -> io:format("match 27~n",[]), 23;

	[4,4,1,1,_] -> io:format("match 31~n",[]), 22;
	[4,4,6,6,_] -> io:format("match 32~n",[]), 21;
	[4,4,5,5,_] -> io:format("match 31~n",[]), 20;
	[4,4,3,3,_] -> io:format("match 31~n",[]), 19;
	[4,4,2,2,_] -> io:format("match 31~n",[]), 18;

	[5,5,1,1,_] -> io:format("match 33~n",[]), 17;
	[5,5,6,6,_] -> io:format("match 33~n",[]), 16;
	[5,5,4,4,_] -> io:format("match 33~n",[]), 15;
	[5,5,3,3,_] -> io:format("match 33~n",[]), 14;
	[5,5,2,2,_] -> io:format("match 33~n",[]), 13;

	[1,1,1,_,_] -> io:format("match 34~n",[]), 12;
	[6,6,6,_,_] -> io:format("match 39~n",[]), 11;
	[5,5,5,_,_] -> io:format("match 38~n",[]), 10;
	[4,4,4,_,_] -> io:format("match 37~n",[]), 9;
	[3,3,3,_,_] -> io:format("match 36~n",[]), 8;
	[2,2,2,_,_] -> io:format("match 35~n",[]), 7;

	[1,1,_,_,_] -> io:format("match 41~n",[]), 6;
	[6,6,_,_,_] -> io:format("match 46~n",[]), 5;
	[5,5,_,_,_] -> io:format("match 45~n",[]), 4;
	[4,4,_,_,_] -> io:format("match 44~n",[]), 3;
	[3,3,_,_,_] -> io:format("match 43~n",[]), 2;
	[2,2,_,_,_] -> io:format("match 42~n",[]), 1;

	_ -> false
    end.


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
            %Dice1_value = random:uniform(6),
            %Dice2_value = random:uniform(6),
            %Dice3_value = random:uniform(6),
            %Dice4_value = random:uniform(6),
            %Dice5_value = random:uniform(6),

            Dice1_value = 3,
            Dice2_value = 1,
            Dice3_value = 2,
            Dice4_value = 2,
            Dice5_value = 3,

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

            SortedRawCallDice = lists:sort([P1Dice1,P1Dice2,P1Dice3,P1Dice4,P1Dice5]),
            ConvertFun = fun([X]) -> list_to_integer([X]) end,
            SortedCallDice = lists:map(ConvertFun, SortedRawCallDice),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Need to check if the call is valid!!!  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
io:format("make call ~w~n",[SortedCallDice]),
            IsValid = getDiceScore(SortedCallDice),
            case IsValid of 
                false ->
                    FromPid ! invalid_call,
                    wait_for_p1_makecall(SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn);
                _ ->
io:format("dice score ~w~n",[IsValid]),
                    FromPid ! valid_call,
                    wait_for_p2_findcall(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise)
            end;
        _ -> 
            io:format("whatt!! ~n",[])
            
    end.

wait_for_p2_findcall(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise) ->
    io:format("wait for p2 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! "p2_findcall";
        {p2_findcall,Player2_uid,FromPid} ->
            %return p1 actual dice combination
io:format("p2_findcall 1 ~n",[]),
            FromPid ! {"p1_calldice", SortedCallDice, "p1_buyin",P1BuyIn, "p1_raise",P1Raise},
io:format("p2_findcall 2 ~n",[]),
            wait_for_p2_trust_or_not(SortedCallDice,[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value],P1BuyIn,P1Raise)
    end.

%append wildcard "9" to fill up the list to lenght 5.
appendWildCardToList(TargetList,0) -> TargetList;
appendWildCardToList(TargetList,Count) -> 
    NewTargetList = lists:append(TargetList,[9]),
    NewCount = Count - 1,
    appendWildCardToList(NewTargetList,NewCount).


%wait_for_p2_trust_or_not(SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise) ->
wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,P1Raise) ->
io:format("wait for p2 trust or not, call: ~w; actual: ~w ~n",[SortedCallDice,SortedActualDice]),
    receive
        {check, FromPid} -> 
            FromPid ! "p2_trust_not";
        {p2_trust,Player2_uid,FromPid,bet,P2Bet} ->
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
                    FromPid ! {p1_dice,SortedCallDice,SortedActualDice,P1BuyIn,P1Raise},
                    wait_for_p2_pick_dice_to_roll(SortedCallDice,SortedActualDice,P1BuyIn,P1Raise,P2Bet)
            end;
        {p2_not_trust,Player2_uid,FromPid,bet,P2Bet} ->
            io:format("p2 not trust, check p1 call and actual! actual: ~w; call: ~w ~n",[SortedActualDice,SortedCallDice]),
            %if p1 actual result not match the dice comb call by p1, p2 win. else p2 lose

            SubtractedList =  SortedActualDice -- SortedCallDice,
            io:format("p2 not trust, SubtractedList: ~w ~n",[SubtractedList]),

            SubtractedSortedActualDice = SortedActualDice -- SubtractedList,
            io:format("p2 not trust, SubtractedSortedActualDice: ~w ~n",[SubtractedSortedActualDice]),

            %append 9 at end to fill up the list to length 5
            AppendCount  = 5 - length(SubtractedSortedActualDice),
            io:format("p2 not trust, AppendCount: ~w ~n",[AppendCount]),
    
            MatchDiceList = appendWildCardToList(SubtractedSortedActualDice,AppendCount),
            io:format("p2 not trust, MatchDiceList: ~w ~n",[MatchDiceList]),

            IsActualMatchCall = case MatchDiceList of 
                CallDiceConverted -> true;
                _ -> false        
            end,
            io:format("p2 not trust 2 ~n"),

            if 
                (IsActualMatchCall) -> 
                    io:format("p1 call match actual! ~n"),
                    FromPid ! {p2_lose,SortedCallDice,SortedActualDice},
                    game_over();
                true ->
                    io:format("p1 call NOT match actual! ~n"),
                    FromPid ! {p2_win,SortedCallDice,SortedActualDice},
                    game_over()
            end
    end.

game_over() ->
    receive 
        {check, FromPid} ->
          FromPid ! "gameover";
        _ ->
          false
    end.

wait_for_p2_pick_dice_to_roll(SortedCallDice,SortedActualDice,P1BuyIn,P1Raise,P2Bet) ->
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
    Pid ! {p2_trust,Player2_uid,self(),bet,P2Bet}.
player2_nottrustcall(Pid,Player2_uid,P2Bet) ->
    Pid ! {p2_not_trust,Player2_uid,self(),bet,P2Bet}.

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
    io:format("p1_calldice. ~n",[]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{p1_call,SortedCallDice},{p1_buyin,P1BuyIn},{p1_raise,P1Raise}]}),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, ["p2_trust", "room_pid", Pid, "p2_uid", Player2_uid, "p2_bet",P2Bet]) -> 
    io:format("p2 trust. ~n",[]),
    player2_trustcall(list_to_pid(Pid),Player2_uid,P2Bet),
    receive
        {p1_dice,SortedCallDice,SortedActualDice,P1BuyIn,P1Raise} ->
io:format("p2 trust get actual p1 call~n"),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{p1_call,SortedCallDice},{p1_actual,SortedActualDice},{p1_buyin,P1BuyIn},{p1_raise,P1Raise}]}),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, ["p2_nottrust", "room_pid", Pid, "p2_uid", Player2_uid, "p2_bet",P2Bet]) -> 
    io:format("p2 not trust. ~n",[]),
    player2_nottrustcall(list_to_pid(Pid),Player2_uid,P2Bet),
    receive
        {p2_lose,SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise} ->
            P1DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'p2_lose'},{p1_call,SortedCallDice},{p1_actual,[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value]},{p1_buyin,P1BuyIn},{p1_raise,P1Raise}]}),
            {html, P1DiceResultJsonStr};
        {p2_win,SortedCallDice,SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value,P1BuyIn,P1Raise} ->
            P1DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'p2_win'},{p1_call,SortedCallDice},{p1_actual,[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value]},{p1_buyin,P1BuyIn},{p1_raise,P1Raise}]}),
            {html, P1DiceResultJsonStr}
    end.



