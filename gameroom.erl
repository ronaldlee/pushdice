-module(gameroom).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).
-record(game_user, {user_id, name, plat_id, plat_type,last_play_date,consecutive_days_played,is_unlocked,coins}).
-define(MAX_DICE_SCORE,90).

getDiceScore(DiceList) ->
io:format("get score int dice list: ~w~n",[DiceList]),
    case DiceList of 
	%{"1","2","3","4","5"} -> io:format("match 1 ~n",[]), true;
	%{"2","3","4","5","6"} -> io:format("match 2 ~n",[]), true;

	[1,1,1,1,1] -> 90;
	[6,6,6,6,6] -> 89;
	[5,5,5,5,5] -> 88;
	[4,4,4,4,4] -> 87;
	[3,3,3,3,3] -> 86;
	[2,2,2,2,2] -> 85;

	[1,1,1,1,_] -> 84;
	[6,6,6,6,_] -> 83;
	[5,5,5,5,_] -> 82;
	[4,4,4,4,_] -> 81;
	[3,3,3,3,_] -> 80;
	[2,2,2,2,_] -> 79;

	[1,1,1,6,6] -> 78;
	[1,1,1,5,5] -> 77;
	[1,1,1,4,4] -> 76;
	[1,1,1,3,3] -> 75;
	[1,1,1,2,2] -> 74;

	[6,6,6,1,1] -> 73;
	[6,6,6,5,5] -> 72;
	[6,6,6,4,4] -> 71;
	[6,6,6,3,3] -> 70;
	[6,6,6,2,2] -> 69;

	[5,5,5,1,1] -> 68;
	[5,5,5,6,6] -> 67;
	[5,5,5,4,4] -> 66;
	[5,5,5,3,3] -> 65;
	[5,5,5,2,2] -> 64;

	[4,4,4,1,1] -> 63;
	[4,4,4,6,6] -> 62;
	[4,4,4,5,5] -> 61;
	[4,4,4,3,3] -> 60;
	[4,4,4,2,2] -> 59;

	[3,3,3,1,1] -> 58;
	[3,3,3,6,6] -> 57;
	[3,3,3,5,5] -> 56;
	[3,3,3,4,4] -> 55;
	[3,3,3,2,2] -> 54;

	[2,2,2,1,1] -> 53;
	[2,2,2,6,6] -> 52;
	[2,2,2,5,5] -> 51;
	[2,2,2,4,4] -> 50;
	[2,2,2,3,3] -> 49;

	[1,1,1,_,_] -> 48;
	[6,6,6,_,_] -> 47;
	[5,5,5,_,_] -> 46;
	[4,4,4,_,_] -> 45;
	[3,3,3,_,_] -> 44;
	[2,2,2,_,_] -> 43;

	[1,1,6,6,_] -> 42;
	[1,1,5,5,_] -> 41;
	[1,1,4,4,_] -> 40;
	[1,1,3,3,_] -> 39;
	[1,1,2,2,_] -> 38;

	[6,6,1,1,_] -> 37;
	[6,6,5,5,_] -> 36;
	[6,6,4,4,_] -> 35;
	[6,6,3,3,_] -> 34;
	[6,6,2,2,_] -> 33;

	[5,5,1,1,_] -> 32;
	[5,5,6,6,_] -> 31;
	[5,5,4,4,_] -> 30;
	[5,5,3,3,_] -> 29;
	[5,5,2,2,_] -> 28;

	[4,4,1,1,_] -> 27;
	[4,4,6,6,_] -> 26;
	[4,4,5,5,_] -> 25;
	[4,4,3,3,_] -> 24;
	[4,4,2,2,_] -> 23;

	[3,3,1,1,_] -> 22;
	[3,3,6,6,_] -> 21;
	[3,3,5,5,_] -> 20;
	[3,3,4,4,_] -> 19;
	[3,3,2,2,_] -> 18;

	[2,2,1,1,_] -> 17;
	[2,2,6,6,_] -> 16;
	[2,2,5,5,_] -> 15;
	[2,2,4,4,_] -> 14;
	[2,2,3,3,_] -> 13;

	[1,1,_,_,_] -> 12;
	[6,6,_,_,_] -> 11;
	[5,5,_,_,_] -> 10;
	[4,4,_,_,_] -> 9;
	[3,3,_,_,_] -> 8;
	[2,2,_,_,_] -> 7;

	[1,_,_,_,_] -> 6;
	[6,_,_,_,_] -> 5;
	[5,_,_,_,_] -> 4;
	[4,_,_,_,_] -> 3;
	[3,_,_,_,_] -> 2;
	[2,_,_,_,_] -> 1;

	_ -> false
    end.

getDiceCombByScore(DiceScore) ->
io:format("get dice comb by score: ~w~n",[DiceScore]),
    case DiceScore of 
	%{"1","2","3","4","5"} -> io:format("match 1 ~n",[]), true;
	%{"2","3","4","5","6"} -> io:format("match 2 ~n",[]), true;

	90->[1,1,1,1,1];
	89->[6,6,6,6,6];
	88->[5,5,5,5,5];
	87->[4,4,4,4,4];
	86->[3,3,3,3,3];
	85->[2,2,2,2,2];

	84->[1,1,1,1,9];
	83->[6,6,6,6,9];
	82->[5,5,5,5,9];
	81->[4,4,4,4,9];
	80->[3,3,3,3,9];
	79->[2,2,2,2,9];

	78->[1,1,1,6,6];
	77->[1,1,1,5,5];
	76->[1,1,1,4,4];
	75->[1,1,1,3,3];
	74->[1,1,1,2,2];

	73->[6,6,6,1,1];
	72->[6,6,6,5,5];
	71->[6,6,6,4,4];
	70->[6,6,6,3,3];
	69->[6,6,6,2,2];

	68->[5,5,5,1,1];
	67->[5,5,5,6,6];
	66->[5,5,5,4,4];
	65->[5,5,5,3,3];
	64->[5,5,5,2,2];

	63->[4,4,4,1,1];
	62->[4,4,4,6,6];
	61->[4,4,4,5,5];
	60->[4,4,4,3,3];
	59->[4,4,4,2,2];

	58->[3,3,3,1,1];
	57->[3,3,3,6,6];
	56->[3,3,3,5,5];
	55->[3,3,3,4,4];
	54->[3,3,3,2,2];

	53->[2,2,2,1,1];
	52->[2,2,2,6,6];
	51->[2,2,2,5,5];
	50->[2,2,2,4,4];
	49->[2,2,2,3,3];

	48->[1,1,1,9,9];
	47->[6,6,6,9,9];
	46->[5,5,5,9,9];
	45->[4,4,4,9,9];
	44->[3,3,3,9,9];
	43->[2,2,2,9,9];

	42->[1,1,6,6,9];
	41->[1,1,5,5,9];
	40->[1,1,4,4,9];
	39->[1,1,3,3,9];
	38->[1,1,2,2,9];

	37->[6,6,1,1,9];
	36->[6,6,5,5,9];
	35->[6,6,4,4,9];
	34->[6,6,3,3,9];
	33->[6,6,2,2,9];

	32->[5,5,1,1,9];
	31->[5,5,6,6,9];
	30->[5,5,4,4,9];
	29->[5,5,3,3,9];
	28->[5,5,2,2,9];

	27->[4,4,1,1,9];
	26->[4,4,6,6,9];
	25->[4,4,5,5,9];
	24->[4,4,3,3,9];
	23->[4,4,2,2,9];

	22->[3,3,1,1,9];
	21->[3,3,6,6,9];
	20->[3,3,5,5,9];
	19->[3,3,4,4,9];
	18->[3,3,2,2,9];

	17->[2,2,1,1,9];
	16->[2,2,6,6,9];
	15->[2,2,5,5,9];
	14->[2,2,4,4,9];
	13->[2,2,3,3,9];

	12->[1,1,9,9,9];
	11->[6,6,9,9,9];
	10->[5,5,9,9,9];
	9->[4,4,9,9,9];
	8->[3,3,9,9,9];
	7->[2,2,9,9,9];

	6->[1,9,9,9,9];
	5->[6,9,9,9,9];
	4->[5,9,9,9,9];
	3->[4,9,9,9,9];
	2->[3,9,9,9,9];
	1->[2,9,9,9,9];

	_ -> false 
    end.

start(Player1_uid,Player2_uid,P1Bind,P1BuyIn) ->
    io:format("start. ~n",[]),

    random:seed(now()),
    %Dice1_value = random:uniform(6),
    %Dice2_value = random:uniform(6),
    %Dice3_value = random:uniform(6),
    %Dice4_value = random:uniform(6),
    %Dice5_value = random:uniform(6),

    %for testing
    %Dice1_value = 3,
    %Dice2_value = 1,
    %Dice3_value = 2,
    %Dice4_value = 2,
    %Dice5_value = 3,
    %NewActualDice = [Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value],

    NewActualDice = rerollDice([1,1,1,1,1],[1,1,1,1,1],[]),

    %sort the dice from low to high
    %[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value] = lists:sort([Dice1_value,Dice2_value,Dice3_value,Dice4_value,Dice5_value]),
    SortedActualDice = lists:sort(NewActualDice),

    Pid = spawn(gameroom, init_gameroom, [Player1_uid,Player2_uid,P1Bind,P1BuyIn,NewActualDice,SortedActualDice,[],[],[SortedActualDice]]),
    %need monitor the game room!
    io:format("start: pid: ~w~n",[Pid]),
    %% register(gameroom_proc, Pid),
    io:format("start. ~n",[]),

    %add this game room to p1 and p2 rooms list
    %gri -> gameroom-init
    %grj -> gameroom-join
    P1RoomsSetKey = io_lib:format("gri_~s",[Player1_uid]),
    P2RoomsSetKey = io_lib:format("grj_~s",[Player2_uid]),
    {ok, C} = eredis:start_link(),
    eredis:q(C, ["SADD", P1RoomsSetKey, pid_to_list(Pid)]),
    eredis:q(C, ["SADD", P2RoomsSetKey, pid_to_list(Pid)]),
    eredis:stop(C),

    {Pid,NewActualDice,SortedActualDice}.

init_gameroom(Player1_uid,Player2_uid,P1Bind,P1BuyIn,NewActualDice,SortedActualDice,AllP1Calls,AllP2Calls,AllDiceResults) ->
    wait_for_p1_makecall(Player1_uid,Player2_uid,[],SortedActualDice,P1Bind,P1BuyIn,P1BuyIn-P1Bind,0,0,0,P1Bind,AllP1Calls,AllP2Calls,AllDiceResults).

wait_for_p1_makecall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
    receive
        {check, FromPid} -> 
            FromPid ! [Player1_uid,p1,wait_for,makecall,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,[],p1_bind,P1Bind, p1_buyin,P1BuyIn, p2_buyin,P2BuyIn,opp_puid,Player2_uid,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p1_makecall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p1,call,ExtPlayer1_uid,FromPid,P1SortedCallDice,raise,P1Raise} ->
            io:format("make call aaa~n",[]),
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_makecall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Need to check if the call is valid!!!  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
io:format("make call ~w~n",[P1SortedCallDice]),
              IsValid = getDiceScore(P1SortedCallDice),
              case IsValid of 
                false ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_makecall(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                _ ->
io:format("dice score ~w~n",[IsValid]),
                    FromPid ! {valid_call,Pot},
                    NewPot = Pot+P1Raise,

                    %append P1SortedCallDice to ALLP1Calls 
                    NewAllP1Calls = lists:append(AllP1Calls,[P1SortedCallDice]),
                    wait_for_p2_acceptgame(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,NewPot,NewAllP1Calls,AllP2Calls,AllDiceResults)
              end
            end;
        _ -> 
            io:format("whatt!! ~n",[])
            
    end.

wait_for_p2_acceptgame(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
    io:format("wait for p2 acceptgame ~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player2_uid,p2,wait_for,accept_game,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,[],p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player1_uid,prev_raise,P1Raise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p2_acceptgame(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p2,acceptgame,ExtPlayer2_uid,FromPid,P2Bind,NewP2BuyIn} ->
io:format("p2 ACCEPT ~n"),
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_acceptgame(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
io:format("p2 wait for trust or not.. ~n"),
                SortedCallDiceScore = getDiceScore(SortedCallDice),
                MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
                NewPot = Pot + P2Bind,
                FromPid ! {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1Bind, "raise",P1Raise,"pot",NewPot},
                wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,[],P1Bind,OrigBuyIn,P1BuyIn,NewP2BuyIn-P2Bind,P1Raise,Bet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults)
            end
    end.

wait_for_p2_findcall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
    io:format("wait for p2 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player2_uid,p2,wait_for,find_call,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player1_uid,prev_raise,P1Raise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p2_findcall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p2,findcall,ExtPlayer2_uid,FromPid} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_findcall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
                SortedCallDiceScore = getDiceScore(SortedCallDice),
                MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
                FromPid ! {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1Bind, "raise",P1Raise,"pot",Pot},
                wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P1Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults)
            end
    end.

wait_for_p1_findcall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P2Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
    io:format("wait for p1 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player1_uid,p1,wait_for,find_call,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player2_uid,prev_raise,P2Raise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p1_findcall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P2Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p1,findcall,ExtPlayer1_uid,FromPid} ->
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_findcall(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P2Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
                SortedCallDiceScore = getDiceScore(SortedCallDice),
                MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
                FromPid ! {p2,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1Bind, "raise",P2Raise,"pot",Pot},
                wait_for_p1_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,P2Raise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults)
            end
    end.

%append wildcard "9" to fill up the list to lenght 5.
appendWildCardToList(TargetList,0) -> TargetList;
appendWildCardToList(TargetList,Count) -> 
    NewTargetList = lists:append(TargetList,[9]),
    NewCount = Count - 1,
    appendWildCardToList(NewTargetList,NewCount).


wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
io:format("wait for p2 trust or not, call: ~w; actual: ~w ~n",[SortedCallDice,SortedActualDice]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player2_uid,p2,wait_for,trust_or_not,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player1_uid,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p2,trust,ExtPlayer2_uid,FromPid,bet,NewBet} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
io:format("trust! ~w, ~w ~n",[P1Bind,PrevRaise]),
            %check if p2 bet matches p1's, if not return error
io:format("trust P1 PrevRaise: ~w, P2Bet: ~w  ~n",[PrevRaise,Bet]),
              if 
                (NewBet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                true ->
                    io:format("p2 valid bet! ~n"),
                    %else return p1's actual dice
                    NewPot = Pot + NewBet,
                    FromPid ! {p2,valid_bet,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,NewBet,NewPot},
                    wait_for_p2_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn-NewBet,PrevRaise,NewBet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults)
              end
            end;
        {p2,not_trust,ExtPlayer2_uid,FromPid,bet,NewBet} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
                if
                  (NewBet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                  true ->
                    NewPot = Pot + NewBet,
                    UpdatedP2BuyIn = P2BuyIn - NewBet,

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
                    io:format("p2 not trust, MatchDiceList: ~w, SortedCallDice: ~w ~n",[MatchDiceList,SortedCallDice]),

                    IsActualMatchCall = case MatchDiceList of 
                        SortedCallDice -> true;
                        _ -> false        
                    end,
                    io:format("p2 not trust 2 ~n"),

                    if 
                        (IsActualMatchCall) -> 
                            io:format("p1 call match actual! p2 lose.. ~n"),
                            FromPid ! {p2,lose,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,NewPot},
                            game_over(Player1_uid,win,Player2_uid,lose,
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn);
                        true ->
                            io:format("p1 call NOT match actual! p2 win.. ~n"),
                            %update p2 player's coin by adding pot
                            FromPid ! {p2,win,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,NewPot},
                            game_over(Player1_uid,lose,Player2_uid,win,
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn)
                    end
                  end
            end
    end.

wait_for_p1_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
io:format("wait for p1 trust or not, call: ~w; actual: ~w ~n",[SortedCallDice,SortedActualDice]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player1_uid,p1,wait_for,trust_or_not,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player2_uid,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p1_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p1,trust,ExtPlayer1_uid,FromPid,bet,NewBet} ->
io:format("p1_trust receive ~n",[]),
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
io:format("p1_trust, bet: ~w, prevraise: ~w~n",[Bet,PrevRaise]),
            %check if p1 bet matches p2's, if not return error
                if 
                  (NewBet < PrevRaise) ->
                    io:format("p1 bad bet! ~n"),
                    FromPid ! {p1,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p1_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                  true ->
                    io:format("p1 valid bet! ~n"),
                    %else return p2's actual dice
                    NewPot = Pot + NewBet,
                    FromPid ! {p1,valid_bet,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,NewBet,NewPot},
                    wait_for_p1_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn-NewBet,P2BuyIn,PrevRaise,NewBet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults)
                end
            end;
        {p1,not_trust,ExtPlayer1_uid,FromPid,bet,NewBet} ->
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
                if
                  (NewBet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                  true ->
                    io:format("p1 not trust, check p2 call and actual! actual: ~w; call: ~w ~n",[SortedActualDice,SortedCallDice]),
                    %if p2 actual result not match the dice comb call by p1, p2 win. else p2 lose

                    SubtractedList =  SortedActualDice -- SortedCallDice,
                    io:format("p1 not trust, SubtractedList: ~w ~n",[SubtractedList]),

                    SubtractedSortedActualDice = SortedActualDice -- SubtractedList,
                    io:format("p1 not trust, SubtractedSortedActualDice: ~w ~n",[SubtractedSortedActualDice]),

                    %append 9 at end to fill up the list to length 5
                    AppendCount  = 5 - length(SubtractedSortedActualDice),
                    io:format("p1 not trust, AppendCount: ~w ~n",[AppendCount]),
    
                    MatchDiceList = appendWildCardToList(SubtractedSortedActualDice,AppendCount),
                    io:format("p1 not trust, MatchDiceList: ~w, SortedCallDice: ~w ~n",[MatchDiceList,SortedCallDice]),

                    IsActualMatchCall = case MatchDiceList of 
                        SortedCallDice -> true;
                        _ -> false        
                    end,
                    io:format("p1 not trust 2 ~n"),

                    if 
                        (IsActualMatchCall) -> 
                            io:format("p2 call match actual! p1 lose.. ~n"),
                            FromPid ! {p1,lose,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Pot},
                            game_over(Player1_uid,lose,Player2_uid,win,
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn);
                        true ->
                            io:format("p2 call NOT match actual! p1 win.. ~n"),
                            %update p2 player's coin by adding pot
                            FromPid ! {p1,win,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Pot},
                            game_over(Player1_uid,win,Player2_uid,lose,
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn)
                    end
                end
            end
    end.

game_over(Player1_uid, P1_result, Player2_uid, P2_result,
          Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn) ->
    receive 
        {check, FromPid} ->
          FromPid ! [game_over,Player1_uid, P1_result, Player2_uid, P2_result,Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn],
          game_over(Player1_uid, P1_result, Player2_uid, P2_result,Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn);
        {kill, FromPid} ->
          true;
        _ ->
          game_over(Player1_uid, P1_result, Player2_uid, P2_result,Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn)
    end.


rerollDice([],[],NewActualDice) -> 
    io:format("rerolled dice presorted: ~w~n",[NewActualDice]),
    NewActualDice;
    %sort the result before returning
    %lists:sort(NewActualDice);
rerollDice(SortedActualDice,ReRollDiceFlagList,NewActualDice) ->
    [SH|ST] = SortedActualDice,
    [RH|RT] = ReRollDiceFlagList,

    if 
      (RH == 1) ->
          %random:seed(now()), this makes random always return same!
          AppendedNewDice = lists:append(NewActualDice,[random:uniform(6)]),
          rerollDice(ST,RT,AppendedNewDice); 
      true ->
          AppendedNewDice = lists:append(NewActualDice,[SH]),
          rerollDice(ST,RT,AppendedNewDice)
    end.


wait_for_p2_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
io:format("wait_for_p2_pick_dice_to_roll ~n"),
    receive
        {check, FromPid} ->
            FromPid ! [Player2_uid,p2,wait_for,rerolldice,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player1_uid,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p2_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p2,reroll,ExtPlayer2_uid,FromPid,ReRollDicePosList} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
                NewActualDice = rerollDice(SortedActualDice,ReRollDicePosList,[]),
                %sort the result before returning
                NewSortedActualDice = lists:sort(NewActualDice),
io:format("p2_reroll NewSortedActualDice: ~w~n",[NewSortedActualDice]),
                FromPid ! {p2,dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1Bind,PrevRaise,Bet,Pot},
                wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,NewSortedActualDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults)
            end
    end.

wait_for_p1_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
io:format("wait_for_p1_pick_dice_to_roll ~n"),
    receive
        {check, FromPid} ->
            FromPid ! [Player1_uid,p1,wait_for,rerolldice,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player2_uid,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p1_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p1,reroll,ExtPlayer1_uid,FromPid,ReRollDicePosList} ->
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_pick_dice_to_roll(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
                NewActualDice = rerollDice(SortedActualDice,ReRollDicePosList,[]),
                %sort the result before returning
                NewSortedActualDice = lists:sort(NewActualDice),
io:format("p1_reroll NewSortedActualDice: ~w~n",[NewSortedActualDice]),
                FromPid ! {p1,dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1Bind,PrevRaise,Bet,Pot},
                wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,NewSortedActualDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults)
            end
    end.

wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
    io:format("wait_for_p2_call~n"),
    receive
        {check, FromPid} ->
            if is_pid(FromPid) -> io:format("from is pid!~n"); true -> io:format("from is not pid!~n") end,

            FromPid ! [Player2_uid,p2,wait_for,call,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player1_uid,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p2,call,ExtPlayer2_uid,FromPid,P2SortedCallDice,raise,P2Raise} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
io:format("p2_call SortedActualDice: ~w~n",[SortedActualDice]),
                %if the new call is "smaller" than the previous call -> error
                %make sure P2SortedCallDice is > SortedCallDice
                PrevSortedCallDiceScore = getDiceScore(SortedCallDice),
                P2SortedCallDiceScore = getDiceScore(P2SortedCallDice),

                if 
                (P2SortedCallDiceScore == false) ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                (P2SortedCallDiceScore == ?MAX_DICE_SCORE) ->
                    %what will happen??
                    NewPot = Pot + P2Raise,
                    NewPrevRaise = P2Raise,

                    FromPid ! {valid_call,NewPot},
                    wait_for_p1_findcall(Player1_uid,Player2_uid,P2SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn-P2Raise,NewPrevRaise,Bet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults);
                (P2SortedCallDiceScore > PrevSortedCallDiceScore) ->
                    io:format("P2 call is greater than prev call ~w, prev: ~w ~n",[P2SortedCallDiceScore,PrevSortedCallDiceScore]),
                    %valid call
                    NewPot = Pot + P2Raise,
                    NewPrevRaise = P2Raise,

                    FromPid ! {valid_call,NewPot},
                    wait_for_p1_findcall(Player1_uid,Player2_uid,P2SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn-P2Raise,NewPrevRaise,Bet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults);
                true ->
                    io:format("Invalid P2 call is less than prev call ~w, prev: ~w ~n",[P2SortedCallDiceScore,PrevSortedCallDiceScore]),
                    FromPid ! {invalid_call,Pot},
                    wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) 
                end
            end;
        true -> 
            wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) 
    end.

wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) ->
    io:format("wait_for_p1_call~n"),
    receive
        {check, FromPid} ->
io:format("wait_for_p1_call check:from ~w~n",[FromPid]),
            if is_pid(FromPid) -> io:format("from is pid!~n"); true -> io:format("from is not pid!~n") end,
            FromPid ! [Player1_uid,p1,wait_for,call,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind,p1_buyin,P1BuyIn,p2_buyin,P2BuyIn,opp_puid,Player2_uid,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults],
            wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
        {p1,call,ExtPlayer1_uid,FromPid,P1SortedCallDice,raise,P1Raise} ->
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
              true ->    
io:format("p1_call SortedActualDice: ~w~n",[SortedActualDice]),
                %if the new call is "smaller" than the previous call -> error
                %make sure P2SortedCallDice is > SortedCallDice
                PrevSortedCallDiceScore = getDiceScore(SortedCallDice),
                P1SortedCallDiceScore = getDiceScore(P1SortedCallDice),

                if 
                (P1SortedCallDiceScore == false) ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                (P1SortedCallDiceScore == ?MAX_DICE_SCORE) ->
                    %what will happen??
                    NewPot = Pot + P1Raise,
                    NewPrevRaise = P1Raise,

                    FromPid ! {valid_call,NewPot},
                    wait_for_p2_findcall(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn-P1Raise,P2BuyIn,NewPrevRaise,Bet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults);
                (P1SortedCallDiceScore > PrevSortedCallDiceScore) ->
                    io:format("P1 call is greater than prev call ~w, prev: ~w ~n",[P1SortedCallDiceScore,PrevSortedCallDiceScore]),
                    %valid call
                    NewPot = Pot + P1Raise,
                    NewPrevRaise = P1Raise,

                    FromPid ! {valid_call,NewPot},
                    wait_for_p2_findcall(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn-P1Raise,P2BuyIn,NewPrevRaise,Bet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults);
                true ->
                    io:format("Invalid P1 call is less than prev call ~w, prev: ~w ~n",[P1SortedCallDiceScore,PrevSortedCallDiceScore]),
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) 
                end
            end;
        true -> 
io:format("wait_for_p1_call others..."),
            wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults) 
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%

accept_game(Pid, P2_uid, P2Bind, P2BuyIn) ->
    Pid ! {p2,acceptgame, P2_uid,self(), P2Bind, P2BuyIn}.

%player1_rolldice(Pid,P1_uid,BuyIn) -> 
%    Pid ! {p1,roll,P1_uid,buy_in, list_to_integer(BuyIn), self()}.

player1_makecall(Pid,ExtPlayer1_uid,SortedCallDice,P1Raise) -> 
io:format("p1_makecall: ~w ~n",[SortedCallDice]),

    Pid ! {p1,call,ExtPlayer1_uid,self(),SortedCallDice,raise,P1Raise},
    receive
        {valid_call,Pot} -> {valid_call,Pot};
        {invalid_call,Pot} -> {invalid_call,Pot};
        invalid_player -> invalid_player
    end.
player2_call(Pid,ExtPlayer2_uid,SortedCallDice,P2Raise) -> 
io:format("p2_call: ~w ~n",[SortedCallDice]),

    Pid ! {p2,call,ExtPlayer2_uid,self(),SortedCallDice,raise,P2Raise},
    receive
        {valid_call,Pot} -> {valid_call,Pot};
        {invalid_call,Pot} -> {invalid_call,Pot};
        invalid_player -> invalid_player
    end.

player1_call(Pid,ExtPlayer1_uid,SortedCallDice,P1Raise) -> 
io:format("p1_call: ~w ~n",[SortedCallDice]),

    Pid ! {p1,call,ExtPlayer1_uid,self(),SortedCallDice,raise,P1Raise},
    receive
        {valid_call,Pot} -> {valid_call,Pot};
        {invalid_call,Pot} -> {invalid_call,Pot};
        invalid_player -> invalid_player
    end.

player2_findcall(Pid,ExtPlayer2_uid) -> 
    Pid ! {p2,findcall,ExtPlayer2_uid,self()}.

player1_findcall(Pid,ExtPlayer1_uid) -> 
    Pid ! {p1,findcall,ExtPlayer1_uid,self()}.

player2_trustcall(Pid,ExtPlayer2_uid,Bet) ->
    Pid ! {p2,trust,ExtPlayer2_uid,self(),bet,list_to_integer(Bet)}.
player1_trustcall(Pid,ExtPlayer1_uid,Bet) ->
    Pid ! {p1,trust,ExtPlayer1_uid,self(),bet,list_to_integer(Bet)}.

player2_nottrustcall(Pid,ExtPlayer2_uid,Bet) ->
    Pid ! {p2,not_trust,ExtPlayer2_uid,self(),bet,list_to_integer(Bet)}.
player1_nottrustcall(Pid,ExtPlayer1_uid,Bet) ->
    Pid ! {p1,not_trust,ExtPlayer1_uid,self(),bet,list_to_integer(Bet)}.

player2_reroll(Pid,ExtPlayer2_uid,ReRollDicePosList) ->
    Pid ! {p2,reroll,ExtPlayer2_uid,self(),ReRollDicePosList}.
player1_reroll(Pid,ExtPlayer1_uid,ReRollDicePosList) ->
    Pid ! {p1,reroll,ExtPlayer1_uid,self(),ReRollDicePosList}.

getPlayerInfo(PlayerID) ->
    %SelectSQL = io_lib:format("SELECT user_id,name,plat_id,plat_type,last_play_date,consecutive_days_played,is_unlocked,coins from user WHERE user_id='~s'",[PlayerID]),
    %SelectResult = emysql:execute(pushdice_pool, SelectSQL),
    %Recs = emysql_util:as_record(SelectResult, game_user, record_info(fields, game_user)),

    Recs = usermodel:getUser(pushdice_pool,PlayerID),
    SelectLength = length(Recs),

    {UserId,Username,PlatId,Coins} = case SelectLength of
        1->
            [{game_user,FoundUserId,FoundUsername,FoundPlatId,FoundPlatType,
             {datetime,{{LastPlayYear,LastPlayMonth,LastPlayDay},{LastPlayHr,LastPlayMin,LastPlaySec}}},
            ConsecDaysPlayed,IsUnlocked,FoundCoins} | _ ] = Recs,
            {FoundUserId,FoundUsername,FoundPlatId,FoundCoins};
        _->
            {PlayerID,unknown,"","0"}
    end.

checkRoomTurns([],MyTurnList,OthersTurnList,P) ->
    {myturn,MyTurnList,othersturn,OthersTurnList};
checkRoomTurns(MyRoomsList,MyTurnList,OthersTurnList,P) ->
    [RoomId|Rooms] = MyRoomsList,
io:format("check room 1 ~s-~w~n",[binary_to_list(RoomId),self()]),
    RoomIdList = binary_to_list(RoomId),
    RoomPid = list_to_pid(RoomIdList),
    RoomPid ! {check,self()},
io:format("check room 2 ~n"),
    receive
        [game_over|Data] ->
            [Player1_uid|Rest1] = Data,
            [P1_result|Rest2] = Rest1,
            [Player2_uid|Rest3] = Rest2,
            [P2_result|Rest4] = Rest3,
            [Pot|Rest5] = Rest4,
            [Bet|Rest6] = Rest5,
            [SortedCallDice|Rest7] = Rest6,
            [SortedActualDice|Rest8] = Rest7,
            [PrevSortedActualDice|Rest9] = Rest8,
            [P1Bind|Rest10] = Rest9,
            [P1BuyIn|Rest11] = Rest10,
            [P2BuyIn|Rest12] = Rest11,
            [PrevRaise|Rest13] = Rest12,
            [OrigBuyIn|Rest14] = Rest13,
%Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn

io:format("GGGGGGGGGGGG AMMMMMMM ovERRRRRRRRRRRRRRR ~n"),
            {P1UserId,P1Username,P1PlatId,P1Coins} = getPlayerInfo(Player1_uid),
            {P2UserId,P2Username,P2PlatId,P2Coins} = getPlayerInfo(Player2_uid),

            if 
              (Player1_uid == P) ->
                NewMyTurnList = lists:append(MyTurnList,[{RoomId,{struct,[{act,gameover},{p,p1},{result,P1_result},
{p1_uid,list_to_binary(Player1_uid)},{p1_name,P1Username},{p1_platid,P1PlatId},
{p2_uid,list_to_binary(Player2_uid)},{p2_name,P2Username},{p2_platid,P2PlatId},
{pot,Pot},{bet,Bet},{currentcall,SortedCallDice},{currentdice,SortedActualDice},{lastdice,PrevSortedActualDice},
{bind,P1Bind},{p1_buyin,P1BuyIn},{p2_buyin,P2BuyIn},{prev_raise,PrevRaise},{orig_buyin,OrigBuyIn}
]} }]);
              true ->
                NewMyTurnList = lists:append(MyTurnList,[{RoomId,{struct,[{act,gameover},{p,p2},{result,P2_result},
{p1_uid,list_to_binary(Player1_uid)},{p1_name,P1Username},{p1_platid,P1PlatId},
{p2_uid,list_to_binary(Player2_uid)},{p2_name,P2Username},{p2_platid,P2PlatId},
{pot,Pot},{bet,Bet},{currentcall,SortedCallDice},{currentdice,SortedActualDice},{lastdice,PrevSortedActualDice},
{bind,P1Bind},{p1_buyin,P1BuyIn},{p2_buyin,P2BuyIn},{prev_raise,PrevRaise},{orig_buyin,OrigBuyIn}
]} }])
            end,
io:format("check room user == P ~w~n",[NewMyTurnList]),
            checkRoomTurns(Rooms,NewMyTurnList,OthersTurnList,P);
        [PlayerID|Data] -> 
io:format("check return ~n",[]),
            [PRole|Rest] = Data,
            [wait_for|Rest2] = Rest,
            [State|Rest3] = Rest2,
            [pot|Rest4] = Rest3,
            [CurrentPot|Rest5] = Rest4,
            [bet|Rest6] = Rest5,
            [CurrentBet|Rest7] = Rest6,
            [sorted_call_dice|Rest8] = Rest7,
            [SCalledDice|Rest9] = Rest8,
            [sorted_actual_dice|Rest10] = Rest9,
            [SActualDice|Rest11] = Rest10,
            [prev_sorted_actual_dice|Rest12] = Rest11,
            [PrevSActualDice|Rest13] = Rest12,
            [p1_bind|Rest14] = Rest13,
            [Bind|Rest15] = Rest14,
            [p1_buyin|Rest16] = Rest15,
            [P1_Buyin|Rest17] = Rest16,
            [p2_buyin|Rest18] = Rest17,
            [P2_Buyin|Rest19] = Rest18,
            [opp_puid|Rest20] = Rest19,
            [OppPuid|Rest21] = Rest20,
            [prev_raise|Rest22] = Rest21,
            [Prev_raise|Rest23] = Rest22,
            [orig_buyin|Rest24] = Rest23,
            [Orig_BuyIn|Rest25] = Rest24,
            [all_p1_calls|Rest26] = Rest25,
            [AllP1Calls|Rest27] = Rest26,
            [all_p2_calls|Rest28] = Rest27,
            [AllP2Calls|Rest29] = Rest28,
            [all_dice_results|Rest30] = Rest29,
            [AllDiceResults|Rest31] = Rest30,

            {UserId,Username,PlatId,Coins} = getPlayerInfo(PlayerID),
            {OppUserId,OppUsername,OppPlatId,OppCoins} = getPlayerInfo(OppPuid),

io:format("check room user ~s,~w,~w~n",[Username,PlayerID,P]),
            if 
              (PlayerID == P) ->
io:format("check room user ==~n",[]),
                %NewMyTurnList = lists:append(MyTurnList,[{RoomId,State}]),
                %NewMyTurnList = lists:append(MyTurnList,[{RoomId,{struct,[{act,State},{p,PRole},{puid,list_to_binary(PlayerID)},{name,list_to_binary(Username)}]} }]),
                NewMyTurnList = lists:append(MyTurnList,[{RoomId,{struct,[{act,State},{p,PRole},{puid,list_to_binary(PlayerID)},{name,Username},{pot,CurrentPot},{bet,CurrentBet},{currentcall,SCalledDice},{currentdice,SActualDice},{lastdice,PrevSActualDice},{bind,Bind},{p1_buyin,P1_Buyin},{p2_buyin,P2_Buyin},{opp_uid,OppUserId},{opp_name,OppUsername},{opp_platid,OppPlatId},{prev_raise,Prev_raise},{orig_buyin,Orig_BuyIn},{all_p1_calls,AllP1Calls},{all_p2_calls,AllP2Calls},{all_dice_results,AllDiceResults}]} }]),
io:format("check room user == P ~w~n",[NewMyTurnList]),
                checkRoomTurns(Rooms,NewMyTurnList,OthersTurnList,P);
              true ->
                %NewOthersTurnList = lists:append(OthersTurnList,[{RoomId,State}]),
                NewOthersTurnList = lists:append(OthersTurnList,[{RoomId,{struct,[{act,State},{p,PRole},{puid,list_to_binary(PlayerID)},{name,Username},{pot,CurrentPot},{bet,CurrentBet},{currentcall,SCalledDice},{currentdice,SActualDice},{lastdice,PrevSActualDice},{bind,Bind},{p1_buyin,P1_Buyin},{p2_buyin,P2_Buyin},{opp_uid,UserId},{opp_name,Username},{opp_platid,PlatId},{prev_raise,Prev_raise},{orig_buyin,Orig_BuyIn},{all_p1_calls,AllP1Calls},{all_p2_calls,AllP2Calls},{all_dice_results,AllDiceResults}]} }]),
io:format("check room user != P ~w~n",[NewOthersTurnList]),
                checkRoomTurns(Rooms,MyTurnList,NewOthersTurnList,P)
            end;
        true -> 
            io:format("no match?~n"),
            checkRoomTurns(MyRoomsList,MyTurnList,OthersTurnList,P)
    end.


%%%%%%%%%%%%%%%%%%%%%%%%%%
out(Arg) ->
    io:format("main. ~n",[]),
    Uri = yaws_api:request_url(Arg),
    [Path|Rest] = string:tokens(Uri#url.path, "/"),
    Method = (Arg#arg.req)#http_request.method,
    MysqlStatus = application:start(emysql),
    io:format("mysql: ~w~n",[MysqlStatus]),

    case MysqlStatus of
       {error,_} ->
           io:format("mysql error ~n",[])
    end,
io:format("PASSSS 1 ~n",[]),
    %try (emysql:remove_pool(pushdice_pool)) of
    %  RemoveVal -> 0
    %catch
    %    _ -> 1
    %end,
io:format("PASSSS 1a ~n",[]),
    Status = try (emysql:add_pool(pushdice_pool, 1, "root", "hellojoe", "localhost", 3306, "pushdice", utf8)) of
            Val -> 0
        catch
            exit:pool_already_exists ->
                io:format("throw error already exist ~n",[]),
                1
        end,
io:format("PASSSS 2 ~w~n",[Status]),

io:format("PASSSS ~n",[]),
    HtmlOutput = out(Arg,Rest),
    emysql:remove_pool(pushdice_pool),
    HtmlOutput.

out(Arg, [Pid, "check"]) -> 
    io:format("check room. ~n",[]),
    list_to_pid(Pid) ! {check,self()},
    RoomState = receive
        State -> State
    end,
    Output = mochijson2:encode({struct, [RoomState]}),
    {html, Output};

out(Arg, ["init", "p1_uid", Player1_uid, "p2_uid", Player2_uid, "bind", P1Bind, "buyin", P1Buyin]) -> 
    io:format("init. ~n",[]),
    {NewPid,ActualDice,SortedDice} = start(Player1_uid,Player2_uid,list_to_integer(P1Bind),list_to_integer(P1Buyin)),
    io:format("init 2. ~w~n",[NewPid]),
    Response = [ {code,"ok"}, {pid,pid_to_list(NewPid)} ],
    ConvertFun = fun({X,Y}) -> {X,list_to_binary(Y)} end,
    StringConverted = lists:map(ConvertFun, Response),
    io:format("init 2. ~w~n",[StringConverted]),
    NewResult = lists:append(StringConverted,[{actual,ActualDice}]),
    NewResult2 = lists:append(NewResult,[{sorted,SortedDice}]),
    Output = mochijson2:encode({struct, NewResult2}),
    {html, Output};

out(Arg, [Pid, "accept_game", "p2_uid", Player2_uid,"bind",P2Bind, "buyin",P2BuyIn]) -> 
    io:format("accept_game. ~w~n",[list_to_pid(Pid)]),
    accept_game(list_to_pid(Pid), Player2_uid, list_to_integer(P2Bind),list_to_integer(P2BuyIn)),
    receive
        {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1Bind, "raise", P1Raise,"pot",Pot} ->
io:format("p1_calldice. ~n",[]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1Bind},{raise,P1Raise},{pot,Pot}]}),
            {html, P1DiceResultJsonStr}
    end;

%out(Arg, [Pid, "rolldice", "p1_uid", Player1_uid,"buy_in", BuyIn]) -> 
%    io:format("!rolldice. ~n",[]),
%    player1_rolldice(list_to_pid(Pid),Player1_uid,BuyIn),
%    receive
%        {dice_result,DiceList,Buyin} ->
%            %build dice result json.
%            DiceResultJsonStr = mochijson2:encode({struct, [{actual,DiceList},{bind,Buyin}]}),
%            {html, DiceResultJsonStr}
%    end;

out(Arg, [Pid, "makecall", "p1_uid", Player1_uid,"call",D1,D2,D3,D4,D5,"raise",P1Raise]) -> 
    io:format("p1 make call. ~n",[]),
    %[SDice1_value,SDice2_value,SDice3_value,SDice4_value,SDice5_value] = lists:sort([D1,D2,D3,D4,D5]),
    P1RaiseInt = list_to_integer(P1Raise),
    SortedRawCallDice = lists:sort([D1,D2,D3,D4,D5]),
    ConvertFun = fun([X]) -> list_to_integer([X]) end,
    SortedCallDice = lists:map(ConvertFun, SortedRawCallDice),
    ValidCall = player1_makecall(list_to_pid(Pid),Player1_uid,SortedCallDice,P1RaiseInt),
    case ValidCall of 
        {valid_call,Pot} ->
            Response = [ {code,valid_call},{call,SortedCallDice},{raise,P1RaiseInt},{pot,Pot} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output};
        {invalid_call,Pot} ->
            Response = [ {code,invalid_call},{call,SortedCallDice},{raise,P1RaiseInt},{pot,Pot} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output};
        invalid_player ->
            Response = [ {code,invalid_player} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output}
    end;

out(Arg, [Pid, "find_call", "p2_uid", Player2_uid]) -> 
    io:format("p2 find out p1 call. ~n",[]),
    player2_findcall(list_to_pid(Pid),Player2_uid),
    receive
        {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1Bind, "raise", P1Raise,"pot",Pot} ->
    io:format("p1_calldice. ~n",[]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1Bind},{raise,P1Raise},{pot,Pot}]}),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, [Pid, "find_call", "p1_uid", Player1_uid]) -> 
    io:format("p1 find out p2 call. ~n",[]),
    player1_findcall(list_to_pid(Pid),Player1_uid),
    receive
        {p2,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1Bind, "raise", P1Raise,"pot",Pot} ->
    io:format("p2_calldice. ~n",[]),
            P2DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1Bind},{raise,P1Raise},{pot,Pot}]}),
            {html, P2DiceResultJsonStr}
    end;

out(Arg, [Pid, "trust", "p2_uid", Player2_uid, "bet",P2Bet]) -> 
    io:format("p2 trust. ~n",[]),
    player2_trustcall(list_to_pid(Pid),Player2_uid,P2Bet),
    receive
        {p2,valid_bet,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Bet,Pot} ->
io:format("p2 trust get actual p1 call~n"),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{actual,SortedActualDice},{bind,P1Bind},{raise,PrevRaise},{bet,Bet},{pot,Pot}]}),
            {html, P1DiceResultJsonStr};
        {p2,bad_bet,P1Bind,PrevRaise,Bet,Pot} ->
io:format("p2 bad bet return result.. ~w ~n",[Bet]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{code,invalid_bet},{bet,Bet},{bind,P1Bind},{raise,PrevRaise},{pot,Pot}]}),
io:format("p2 bad bet return result html ~s~n",[P1DiceResultJsonStr]),
            {html, P1DiceResultJsonStr}
        %_ -> 
        %    io:format("p2_trust not found callback! ~n")
    end;

out(Arg, [Pid, "nottrust", "p2_uid", Player2_uid, "bet",P2Bet]) -> 
    io:format("p2 not trust. ~n",[]),
    player2_nottrustcall(list_to_pid(Pid),Player2_uid,P2Bet),
    receive
        {p2,lose,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Pot} ->
            P1DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'lose'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1Bind},{raise,PrevRaise}]}),
            {html, P1DiceResultJsonStr};
        {p2,win,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Pot} ->
            P1DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'win'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1Bind},{raise,PrevRaise}]}),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, [Pid, "trust", "p1_uid", Player1_uid, "bet",P1Bet]) -> 
    io:format("p1 trust. ~n",[]),
    player1_trustcall(list_to_pid(Pid),Player1_uid,P1Bet),
    io:format("p1 trust after. ~n",[]),
    receive
        {p1,valid_bet,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Bet,Pot} ->
io:format("p1_trust valid_bet ~n"),
            DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{actual,SortedActualDice},{bind,P1Bind},{raise,PrevRaise},{bet,Bet},{pot,Pot}]}),
            {html, DiceResultJsonStr};
        {p1,bad_bet,P1Bind,PrevRaise,Bet,Pot} ->
io:format("p1_trust bad_bet ~n"),
            DiceResultJsonStr = mochijson2:encode({struct, [{code,invalid_bet},{bet,Bet},{bind,P1Bind},{raise,PrevRaise},{pot,Pot}]}),
            {html, DiceResultJsonStr}
        %_ -> 
        %    io:format("p2_trust not found callback! ~n")
    end;

out(Arg, [Pid, "nottrust", "p1_uid", Player1_uid, "bet",P1Bet]) -> 
    io:format("p1 not trust. ~n",[]),
    player1_nottrustcall(list_to_pid(Pid),Player1_uid,P1Bet),
    receive
        {p1,lose,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Pot} ->
            DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'lose'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1Bind},{raise,PrevRaise}]}),
            {html, DiceResultJsonStr};
        {p1,win,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Pot} ->
            DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'win'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1Bind},{raise,PrevRaise}]}),
            {html, DiceResultJsonStr}
    end;

%when the dice pos is "1", mean that it is reroll, otherwise 0 means no roll
out(Arg, [Pid, "rerolldice", "p2_uid", Player2_uid, "dice_pos",DicePos1flag,DicePos2flag,DicePos3flag,DicePos4flag,DicePos5flag]) -> 
    io:format("p2 reroll. ~n",[]),
    ReRollDicePosList = [list_to_integer(DicePos1flag),list_to_integer(DicePos2flag),list_to_integer(DicePos3flag),list_to_integer(DicePos4flag),list_to_integer(DicePos5flag)],
    player2_reroll(list_to_pid(Pid),Player2_uid,ReRollDicePosList),
    receive
        {p2,dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1Bind,P1Raise,P2Bet,Pot} ->
io:format("p2_dicerolled~n"),
            ResultJsonStr = mochijson2:encode({struct, [{roll_pos,ReRollDicePosList},{rolled_dice,NewActualDice},{sorted,NewSortedActualDice},{call,SortedCallDice},{bind,P1Bind},{raise,P1Raise},{bet,P2Bet},{pot,Pot}]}),
            {html, ResultJsonStr}
    end;

out(Arg, [Pid, "call", "p2_uid", Player2_uid, "call",D1,D2,D3,D4,D5,"raise",P2Raise]) -> 
    io:format("p2 make call. ~s~n",[Pid]),
    io:format("p2 make call2 ~w~n",[Pid]),
    P2RaiseInt = list_to_integer(P2Raise),
    SortedRawCallDice = lists:sort([D1,D2,D3,D4,D5]),
    ConvertFun = fun([X]) -> list_to_integer([X]) end,
    SortedCallDice = lists:map(ConvertFun, SortedRawCallDice),
    ValidCall = player2_call(list_to_pid(Pid),Player2_uid,SortedCallDice,P2RaiseInt),
    case ValidCall of 
        {valid_call,Pot} ->
            Response = [ {code,valid_call},{call,SortedCallDice},{raise,P2RaiseInt},{pot,Pot} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output};
        {invalid_call,Pot} ->
            Response = [ {code,invalid_call},{call,SortedCallDice},{raise,P2RaiseInt},{pot,Pot} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output};
        invalid_player ->
            Response = [ {code,invalid_player} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output}
    end;

out(Arg, [Pid, "rerolldice", "p1_uid", Player1_uid, "dice_pos",DicePos1flag,DicePos2flag,DicePos3flag,DicePos4flag,DicePos5flag]) -> 
    io:format("p1 reroll. ~n",[]),
    ReRollDicePosList = [list_to_integer(DicePos1flag),list_to_integer(DicePos2flag),list_to_integer(DicePos3flag),list_to_integer(DicePos4flag),list_to_integer(DicePos5flag)],
    player1_reroll(list_to_pid(Pid),Player1_uid,ReRollDicePosList),
    receive
        {p1,dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1Bind,PrevRaise,Bet,Pot} ->
io:format("p1_dicerolled~n"),
            ResultJsonStr = mochijson2:encode({struct, [{roll_pos,ReRollDicePosList},{rolled_dice,NewActualDice},{sorted,NewSortedActualDice},{call,SortedCallDice},{bind,P1Bind},{raise,PrevRaise},{bet,Bet},{pot,Pot}]}),
            {html, ResultJsonStr}
    end;

out(Arg, [Pid, "call", "p1_uid", Player2_uid, "call",D1,D2,D3,D4,D5,"raise",P1Raise]) -> 
    io:format("p1 make call. ~s~n",[Pid]),
    P1RaiseInt = list_to_integer(P1Raise),
    SortedRawCallDice = lists:sort([D1,D2,D3,D4,D5]),
    ConvertFun = fun([X]) -> list_to_integer([X]) end,
    SortedCallDice = lists:map(ConvertFun, SortedRawCallDice),
    ValidCall = player1_call(list_to_pid(Pid),Player2_uid,SortedCallDice,P1RaiseInt),
    case ValidCall of 
        {valid_call,Pot} ->
            Response = [ {code,valid_call},{call,SortedCallDice},{raise,P1RaiseInt},{pot,Pot} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output};
        {invalid_call,Pot} ->
            Response = [ {code,invalid_call},{call,SortedCallDice},{raise,P1RaiseInt},{pot,Pot} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output};
        invalid_player ->
            Response = [ {code,invalid_player} ],
            Output = mochijson2:encode({struct, Response}),
            {html, Output}
    end;

out(Arg, ["del", "uid", Uid]) -> 
    io:format("list game rooms. ~n",[]),
    InitRoomsSetKey = io_lib:format("gri_~s",[Uid]),
    JoinRoomsSetKey = io_lib:format("grj_~s",[Uid]),

    {ok, C} = eredis:start_link(),
    eredis:q(C, ["DEL", InitRoomsSetKey]),
    eredis:q(C, ["DEL", JoinRoomsSetKey]),
    eredis:stop(C),

    Output = mochijson2:encode({struct, [ {status,ok} ]}),

    {html, Output};

out(Arg, ["list", "uid", Uid]) -> 
    io:format("list game rooms. ~n",[]),
    InitRoomsSetKey = io_lib:format("gri_~s",[Uid]),
    JoinRoomsSetKey = io_lib:format("grj_~s",[Uid]),

    {ok, C} = eredis:start_link(),
    {ok, InitRooms} = eredis:q(C, ["SMEMBERS", InitRoomsSetKey]),
    {ok, JoinRooms} = eredis:q(C, ["SMEMBERS", JoinRoomsSetKey]),
    eredis:stop(C),
    %InitRooms = [],
    %JoinRooms = [],

    %for each room, call "check" to see whos turn
    %if initroom list, p1 means your turn
    MyTurnList = [],
    OthersTurnList = [],
    io:format("list game rooms 1. ~n",[]),
    {myturn,MyTurnList1,othersturn,OthersTurnList1} = checkRoomTurns(InitRooms,MyTurnList,OthersTurnList,Uid),
    io:format("list game rooms 2. ~w , ~w ~n",[MyTurnList1,OthersTurnList1]),
    %if joinroom list, p2 means your turn
    {myturn,MyTurnList2,othersturn,OthersTurnList2} = checkRoomTurns(JoinRooms,MyTurnList1,OthersTurnList1,Uid),
    %io:format("list game rooms 3. ~w , ~w ~n",[MyTurnList2,OthersTurnList2]),

    io:format("list game rooms 3. ~n",[]),
    Response = [ {myturn, {struct,MyTurnList2} },{othersturn, {struct,OthersTurnList2} } ],
    Output = mochijson2:encode({struct, Response}),
    io:format("list game rooms 4. ~n",[]),
    {html, Output}.
