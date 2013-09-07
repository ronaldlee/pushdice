-module(gameroom).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).
-define(MAX_DICE_SCORE,84).

getDiceScore(DiceList) ->
io:format("get score int dice list: ~w~n",[DiceList]),
    case DiceList of 
	%{"1","2","3","4","5"} -> io:format("match 1 ~n",[]), true;
	%{"2","3","4","5","6"} -> io:format("match 2 ~n",[]), true;

	[1,1,1,1,1] -> 84;
	[6,6,6,6,6] -> 83;
	[5,5,5,5,5] -> 82;
	[4,4,4,4,4] -> 81;
	[3,3,3,3,3] -> 80;
	[2,2,2,2,2] -> 79;

	[1,1,1,1,_] -> 78;
	[6,6,6,6,_] -> 77;
	[5,5,5,5,_] -> 76;
	[4,4,4,4,_] -> 75;
	[3,3,3,3,_] -> 74;
	[2,2,2,2,_] -> 73;

	[1,1,1,6,6] -> 72;
	[1,1,1,5,5] -> 71;
	[1,1,1,4,4] -> 70;
	[1,1,1,3,3] -> 69;
	[1,1,1,2,2] -> 68;

	[6,6,6,1,1] -> 67;
	[6,6,6,5,5] -> 66;
	[6,6,6,4,4] -> 65;
	[6,6,6,3,3] -> 64;
	[6,6,6,2,2] -> 63;

	[5,5,5,1,1] -> 62;
	[5,5,5,6,6] -> 61;
	[5,5,5,4,4] -> 60;
	[5,5,5,3,3] -> 59;
	[5,5,5,2,2] -> 58;

	[4,4,4,1,1] -> 57;
	[4,4,4,6,6] -> 56;
	[4,4,4,5,5] -> 55;
	[4,4,4,3,3] -> 54;
	[4,4,4,2,2] -> 53;

	[3,3,3,1,1] -> 52;
	[3,3,3,6,6] -> 51;
	[3,3,3,5,5] -> 50;
	[3,3,3,4,4] -> 49;
	[3,3,3,2,2] -> 48;

	[2,2,2,1,1] -> 47;
	[2,2,2,6,6] -> 46;
	[2,2,2,5,5] -> 45;
	[2,2,2,4,4] -> 44;
	[2,2,2,3,3] -> 43;

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

	[1,1,1,_,_] -> 12;
	[6,6,6,_,_] -> 11;
	[5,5,5,_,_] -> 10;
	[4,4,4,_,_] -> 9;
	[3,3,3,_,_] -> 8;
	[2,2,2,_,_] -> 7;

	[1,1,_,_,_] -> 6;
	[6,6,_,_,_] -> 5;
	[5,5,_,_,_] -> 4;
	[4,4,_,_,_] -> 3;
	[3,3,_,_,_] -> 2;
	[2,2,_,_,_] -> 1;

	_ -> false
    end.

getDiceCombByScore(DiceScore) ->
io:format("get dice comb by score: ~w~n",[DiceScore]),
    case DiceScore of 
	%{"1","2","3","4","5"} -> io:format("match 1 ~n",[]), true;
	%{"2","3","4","5","6"} -> io:format("match 2 ~n",[]), true;

	84->[1,1,1,1,1];
	83->[6,6,6,6,6];
	82->[5,5,5,5,5];
	81->[4,4,4,4,4];
	80->[3,3,3,3,3];
	79->[2,2,2,2,2];

	78->[1,1,1,1,9];
	77->[6,6,6,6,9];
	76->[5,5,5,5,9];
	75->[4,4,4,4,9];
	74->[3,3,3,3,9];
	73->[2,2,2,2,9];

	72->[1,1,1,6,6];
	71->[1,1,1,5,5];
	70->[1,1,1,4,4];
	69->[1,1,1,3,3];
	68->[1,1,1,2,2];

	67->[6,6,6,1,1];
	66->[6,6,6,5,5];
	65->[6,6,6,4,4];
	64->[6,6,6,3,3];
	63->[6,6,6,2,2];

	62->[5,5,5,1,1];
	61->[5,5,5,6,6];
	60->[5,5,5,4,4];
	59->[5,5,5,3,3];
	58->[5,5,5,2,2];

	57->[4,4,4,1,1];
	56->[4,4,4,6,6];
	55->[4,4,4,5,5];
	54->[4,4,4,3,3];
	53->[4,4,4,2,2];

	52->[3,3,3,1,1];
	51->[3,3,3,6,6];
	50->[3,3,3,5,5];
	49->[3,3,3,4,4];
	48->[3,3,3,2,2];

	47->[2,2,2,1,1];
	46->[2,2,2,6,6];
	45->[2,2,2,5,5];
	44->[2,2,2,4,4];
	43->[2,2,2,3,3];

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

	12->[1,1,1,9,9];
	11->[6,6,6,9,9];
	10->[5,5,5,9,9];
	9->[4,4,4,9,9];
	8->[3,3,3,9,9];
	7->[2,2,2,9,9];

	6->[1,1,9,9,9];
	5->[6,6,9,9,9];
	4->[5,5,9,9,9];
	3->[4,4,9,9,9];
	2->[3,3,9,9,9];
	1->[2,2,9,9,9];

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
            FromPid ! [{state,"init_gameroom"},{p1_uid,Player1_uid},{p2_uid,Player2_uid}];
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
            FromPid ! [{state,"wait_for_p1_rolldice"}];
        {p1_roll,Player1_uid,buy_in, BuyIn, FromPid} ->
        %check if p1 has enough to make the blind first
            io:format("p1 roll dice ~n",[]),
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

            io:format("p1 roll dice: ~w ~n",[SortedActualDice]),
            FromPid ! {dice_result,SortedActualDice,BuyIn},
            wait_for_p1_makecall([],SortedActualDice,BuyIn,0,0,BuyIn)
    end.

wait_for_p1_makecall(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) ->
    receive
        {check, FromPid} -> 
            FromPid ! [{state,"wait_for_p1_makecall"},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{pot,Pot}];
        {p1_call,Player1_uid,FromPid,P1SortedCallDice,p1_raise,P1Raise} ->
            io:format("make call aaa~n",[]),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Need to check if the call is valid!!!  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
io:format("make call ~w~n",[P1SortedCallDice]),
            IsValid = getDiceScore(P1SortedCallDice),
            case IsValid of 
                false ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_makecall(P1SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot);
                _ ->
io:format("dice score ~w~n",[IsValid]),
                    FromPid ! {valid_call,Pot},
                    NewPot = Pot+P1Raise,
                    wait_for_p2_findcall(P1SortedCallDice,SortedActualDice,P1BuyIn,P1BuyIn+P1Raise,NewPot)
            end;
        _ -> 
            io:format("whatt!! ~n",[])
            
    end.

wait_for_p2_findcall(SortedCallDice,SortedActualDice,P1BuyIn,P1Raise,Pot) ->
    io:format("wait for p2 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [{state,"wait_for_p2_findcall"},{sorted_call_dice,SortedCallDice},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{p1_raise,P1Raise},{pot,Pot}];
        {p2_findcall,Player2_uid,FromPid} ->
            %return p1 actual dice combination
io:format("p2_findcall 1 ~n",[]),
            %find the min dice combination
            SortedCallDiceScore = getDiceScore(SortedCallDice),
            MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
io:format("p2_findcall min call:  ~w~n",[MinSortedCallDice]),

            FromPid ! {"p1_calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1BuyIn, "p1_raise",P1Raise,"pot",Pot},
io:format("p2_findcall 2 ~n",[]),
            wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,P1Raise,Pot)
    end.

wait_for_p1_findcall(SortedCallDice,SortedActualDice,P1BuyIn,P2Raise,Pot) ->
    io:format("wait for p1 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [{state,"wait_for_p1_findcall"},{sorted_call_dice,SortedCallDice},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{p2_raise,P2Raise},{pot,Pot}];
        {p1_findcall,Player21uid,FromPid} ->
            %return p1 actual dice combination
io:format("p1_findcall 1 ~n",[]),
            SortedCallDiceScore = getDiceScore(SortedCallDice),
            MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
io:format("p1_findcall min call:  ~w~n",[MinSortedCallDice]),

            FromPid ! {"p2_calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1BuyIn, "p2_raise",P2Raise,"pot",Pot},
io:format("p1_findcall 2 ~n",[]),
            wait_for_p1_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,P2Raise,Pot)
    end.

%append wildcard "9" to fill up the list to lenght 5.
appendWildCardToList(TargetList,0) -> TargetList;
appendWildCardToList(TargetList,Count) -> 
    NewTargetList = lists:append(TargetList,[9]),
    NewCount = Count - 1,
    appendWildCardToList(NewTargetList,NewCount).


wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot) ->
io:format("wait for p2 trust or not, call: ~w; actual: ~w ~n",[SortedCallDice,SortedActualDice]),
    receive
        {check, FromPid} -> 
            FromPid ! [{state,"wait_for_p2_trust_or_not"},{sorted_call_dice,SortedCallDice},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{prev_raise,PrevRaise},{pot,Pot}];
        {p2_trust,Player2_uid,FromPid,bet,Bet} ->
io:format("trust! ~w, ~w ~n",[P1BuyIn,PrevRaise]),
            %check if p2 bet matches p1's, if not return error
io:format("trust P1 PrevRaise: ~w, P2Bet: ~w  ~n",[PrevRaise,Bet]),
            if 
                (Bet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2_bad_bet,P1BuyIn,PrevRaise,Bet,Pot},
                    wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot);
                true ->
                    io:format("p2 valid bet! ~n"),
                    %else return p1's actual dice
                    NewPot = Pot + Bet,
                    FromPid ! {p2_valid_bet,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,NewPot},
                    wait_for_p2_pick_dice_to_roll(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,NewPot)
            end;
        {p2_not_trust,Player2_uid,FromPid,bet,Bet} ->
            if
                (Bet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2_bad_bet,P1BuyIn,PrevRaise,Bet,Pot},
                    wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot);
                true ->
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
                            FromPid ! {p2_lose,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot},
                            game_over();
                        true ->
                            io:format("p1 call NOT match actual! p2 win.. ~n"),
                            %update p2 player's coin by adding pot
                            FromPid ! {p2_win,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot},
                            game_over()
                    end
            end
    end.

wait_for_p1_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot) ->
io:format("wait for p1 trust or not, call: ~w; actual: ~w ~n",[SortedCallDice,SortedActualDice]),
    receive
        {check, FromPid} -> 
            FromPid ! [{state,"wait_for_p1_trust_or_not"},{sorted_call_dice,SortedCallDice},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{prev_raise,PrevRaise},{pot,Pot}];
        {p1_trust,Player1_uid,FromPid,bet,Bet} ->
io:format("p1_trust, bet: ~w, prevraise: ~w~n",[Bet,PrevRaise]),
            %check if p1 bet matches p2's, if not return error
            if 
                (Bet < PrevRaise) ->
                    io:format("p1 bad bet! ~n"),
                    FromPid ! {p1_bad_bet,P1BuyIn,PrevRaise,Bet,Pot},
                    wait_for_p1_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot);
                true ->
                    io:format("p1 valid bet! ~n"),
                    %else return p2's actual dice
                    NewPot = Pot + Bet,
                    FromPid ! {p1_valid_bet,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,NewPot},
                    wait_for_p1_pick_dice_to_roll(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,NewPot)
            end;
        {p1_not_trust,Player1_uid,FromPid,bet,Bet} ->
            if
                (Bet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2_bad_bet,P1BuyIn,PrevRaise,Bet,Pot},
                    wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot);
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
                            FromPid ! {p1_lose,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot},
                            game_over();
                        true ->
                            io:format("p2 call NOT match actual! p1 win.. ~n"),
                            %update p2 player's coin by adding pot
                            FromPid ! {p1_win,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot},
                            game_over()
                    end
            end
    end.

game_over() ->
    receive 
        {check, FromPid} ->
          FromPid ! [{state,"game_over"}];
        _ ->
          false
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


wait_for_p2_pick_dice_to_roll(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) ->
io:format("wait_for_p2_pick_dice_to_roll ~n"),
    receive
        {check, FromPid} ->
            FromPid ! [{state,"wait_for_p2_pick_dice_to_roll"},{sorted_call_dice,SortedCallDice},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{prev_raise,PrevRaise},{bet,Bet},{pot,Pot}];
        {p2_reroll,Player2_uid,FromPid,ReRollDicePosList} ->
            NewActualDice = rerollDice(SortedActualDice,ReRollDicePosList,[]),
            %sort the result before returning
            NewSortedActualDice = lists:sort(NewActualDice),
io:format("p2_reroll NewSortedActualDice: ~w~n",[NewSortedActualDice]),
            FromPid ! {p2_dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1BuyIn,PrevRaise,Bet,Pot},
            wait_for_p2_call(SortedCallDice,NewSortedActualDice,P1BuyIn,PrevRaise,Bet,Pot)
    end.

wait_for_p1_pick_dice_to_roll(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) ->
io:format("wait_for_p1_pick_dice_to_roll ~n"),
    receive
        {check, FromPid} ->
            FromPid ! [{state,"wait_for_p1_pick_dice_to_roll"},{sorted_call_dice,SortedCallDice},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{prev_raise,PrevRaise},{bet,Bet},{pot,Pot}];
        {p1_reroll,Player1_uid,FromPid,ReRollDicePosList} ->
            NewActualDice = rerollDice(SortedActualDice,ReRollDicePosList,[]),
            %sort the result before returning
            NewSortedActualDice = lists:sort(NewActualDice),
io:format("p1_reroll NewSortedActualDice: ~w~n",[NewSortedActualDice]),
            FromPid ! {p1_dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1BuyIn,PrevRaise,Bet,Pot},
            wait_for_p1_call(SortedCallDice,NewSortedActualDice,P1BuyIn,PrevRaise,Bet,Pot)
    end.

wait_for_p2_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) ->
    io:format("wait_for_p2_call~n"),
    receive
        {p2_call,Player2_uid,FromPid,P2SortedCallDice,p2_raise,P2Raise} ->
io:format("p2_call SortedActualDice: ~w~n",[SortedActualDice]),
            %if the new call is "smaller" than the previous call -> error
            %make sure P2SortedCallDice is > SortedCallDice
            PrevSortedCallDiceScore = getDiceScore(SortedCallDice),
            P2SortedCallDiceScore = getDiceScore(P2SortedCallDice),

            if 
                (P2SortedCallDiceScore == false) ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p2_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot);
                (P2SortedCallDiceScore == ?MAX_DICE_SCORE) ->
                    %what will happen??
                    NewPot = Pot + P2Raise,
                    NewPrevRaise = P2Raise,

                    FromPid ! {valid_call,NewPot},
                    %wait_for_p1_trust_or_not(P2SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                    wait_for_p1_findcall(P2SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                (P2SortedCallDiceScore > PrevSortedCallDiceScore) ->
                    io:format("P2 call is greater than prev call ~w, prev: ~w ~n",[P2SortedCallDiceScore,PrevSortedCallDiceScore]),
                    %valid call
                    NewPot = Pot + P2Raise,
                    NewPrevRaise = P2Raise,

                    FromPid ! {valid_call,NewPot},
                    %wait_for_p1_trust_or_not(P2SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                    wait_for_p1_findcall(P2SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                true ->
                    io:format("Invalid P2 call is less than prev call ~w, prev: ~w ~n",[P2SortedCallDiceScore,PrevSortedCallDiceScore]),
                    FromPid ! {invalid_call,Pot},
                    wait_for_p2_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) 
            end;
        true -> 
            wait_for_p2_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) 
    end.

wait_for_p1_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) ->
    io:format("wait_for_p1_call~n"),
    receive
        {check, FromPid} ->
            FromPid ! [{state,"wait_for_p1_call"},{sorted_call_dice,SortedCallDice},{sorted_actual_dice,SortedActualDice},{p1_bind,P1BuyIn},{prev_raise,PrevRaise},{bet,Bet},{pot,Pot}];
        {p1_call,Player1_uid,FromPid,P1SortedCallDice,p1_raise,P1Raise} ->
io:format("p1_call SortedActualDice: ~w~n",[SortedActualDice]),
            %if the new call is "smaller" than the previous call -> error
            %make sure P2SortedCallDice is > SortedCallDice
            PrevSortedCallDiceScore = getDiceScore(SortedCallDice),
            P1SortedCallDiceScore = getDiceScore(P1SortedCallDice),

            if 
                (P1SortedCallDiceScore == false) ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot);
                (P1SortedCallDiceScore == ?MAX_DICE_SCORE) ->
                    %what will happen??
                    NewPot = Pot + PrevRaise,
                    NewPrevRaise = PrevRaise,

                    FromPid ! {valid_call,NewPot},
                    %wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                    wait_for_p2_findcall(P1SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                (P1SortedCallDiceScore > PrevSortedCallDiceScore) ->
                    io:format("P1 call is greater than prev call ~w, prev: ~w ~n",[P1SortedCallDiceScore,PrevSortedCallDiceScore]),
                    %valid call
                    NewPot = Pot + PrevRaise,
                    NewPrevRaise = PrevRaise,

                    FromPid ! {valid_call,NewPot},
                    %wait_for_p2_trust_or_not(SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                    wait_for_p2_findcall(P1SortedCallDice,SortedActualDice,P1BuyIn,NewPrevRaise,NewPot);
                true ->
                    io:format("Invalid P1 call is less than prev call ~w, prev: ~w ~n",[P1SortedCallDiceScore,PrevSortedCallDiceScore]),
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) 
            end;
        true -> 
            wait_for_p1_call(SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot) 
    end.

join_gameroom(Pid,Player2_uid) ->
    Pid ! {join, Player2_uid}.

player1_rolldice(Pid,Player1_uid,BuyIn) -> 
    Pid ! {p1_roll,Player1_uid,buy_in, list_to_integer(BuyIn), self()}.

player1_makecall(Pid,Player1_uid,SortedCallDice,P1Raise) -> 
io:format("p1_makecall: ~w ~n",[SortedCallDice]),

    Pid ! {p1_call,Player1_uid,self(),SortedCallDice,p1_raise,P1Raise},
    receive
        {valid_call,Pot} -> {valid_call,Pot};
        {invalid_call,Pot} -> {invalid_call,Pot}
    end.
player2_call(Pid,Player2_uid,SortedCallDice,P2Raise) -> 
io:format("p2_call: ~w ~n",[SortedCallDice]),

    Pid ! {p2_call,Player2_uid,self(),SortedCallDice,p2_raise,P2Raise},
    receive
        {valid_call,Pot} -> {valid_call,Pot};
        {invalid_call,Pot} -> {invalid_call,Pot}
    end.

player1_call(Pid,Player1_uid,SortedCallDice,P1Raise) -> 
io:format("p1_call: ~w ~n",[SortedCallDice]),

    Pid ! {p1_call,Player1_uid,self(),SortedCallDice,p1_raise,P1Raise},
    receive
        {valid_call,Pot} -> {valid_call,Pot};
        {invalid_call,Pot} -> {invalid_call,Pot}
    end.

player2_findcall(Pid,Player2_uid) -> 
    Pid ! {p2_findcall,Player2_uid,self()}.

player1_findcall(Pid,Player1_uid) -> 
    Pid ! {p1_findcall,Player1_uid,self()}.

player2_trustcall(Pid,Player2_uid,Bet) ->
    Pid ! {p2_trust,Player2_uid,self(),bet,list_to_integer(Bet)}.
player1_trustcall(Pid,Player1_uid,Bet) ->
    Pid ! {p1_trust,Player1_uid,self(),bet,list_to_integer(Bet)}.

player2_nottrustcall(Pid,Player2_uid,Bet) ->
    Pid ! {p2_not_trust,Player2_uid,self(),bet,list_to_integer(Bet)}.
player1_nottrustcall(Pid,Player1_uid,Bet) ->
    Pid ! {p1_not_trust,Player1_uid,self(),bet,list_to_integer(Bet)}.

player2_reroll(Pid,Player2_uid,ReRollDicePosList) ->
    Pid ! {p2_reroll,Player2_uid,self(),ReRollDicePosList}.
player1_reroll(Pid,Player1_uid,ReRollDicePosList) ->
    Pid ! {p1_reroll,Player1_uid,self(),ReRollDicePosList}.

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
        {dice_result,DiceList,Buyin} ->
            %build dice result json.
            DiceResultJsonStr = mochijson2:encode({struct, [{actual,DiceList},{bind,Buyin}]}),
            {html, DiceResultJsonStr}
    end;

out(Arg, ["makecall", "room_pid", Pid, "p1_uid", Player1_uid,"call",D1,D2,D3,D4,D5,"raise",P1Raise]) -> 
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
            {html, Output}
    end;

out(Arg, ["check", "room_pid", Pid]) -> 
    io:format("check room. ~n",[]),
    list_to_pid(Pid) ! {'check',self()},
    RoomState = receive
        State -> State
    end,
    Output = mochijson2:encode({struct, [RoomState]}),
    {html, Output};

out(Arg, ["get_p1_call", "room_pid", Pid, "p2_uid", Player2_uid]) -> 
    io:format("p2 find out p1 call. ~n",[]),
    player2_findcall(list_to_pid(Pid),Player2_uid),
    receive
        {"p1_calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1BuyIn, "p1_raise", P1Raise,"pot",Pot} ->
    io:format("p1_calldice. ~n",[]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1BuyIn},{raise,P1Raise},{pot,Pot}]}),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, ["get_p2_call", "room_pid", Pid, "p1_uid", Player1_uid]) -> 
    io:format("p1 find out p2 call. ~n",[]),
    player1_findcall(list_to_pid(Pid),Player1_uid),
    receive
        {"p2_calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1BuyIn, "p2_raise", P1Raise,"pot",Pot} ->
    io:format("p2_calldice. ~n",[]),
            P2DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1BuyIn},{raise,P1Raise},{pot,Pot}]}),
            {html, P2DiceResultJsonStr}
    end;

out(Arg, ["p2_trust", "room_pid", Pid, "p2_uid", Player2_uid, "bet",P2Bet]) -> 
    io:format("p2 trust. ~n",[]),
    player2_trustcall(list_to_pid(Pid),Player2_uid,P2Bet),
    receive
        {p2_valid_bet,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot} ->
io:format("p2 trust get actual p1 call~n"),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{actual,SortedActualDice},{bind,P1BuyIn},{raise,PrevRaise},{bet,Bet},{pot,Pot}]}),
            {html, P1DiceResultJsonStr};
        {p2_bad_bet,P1BuyIn,PrevRaise,Bet,Pot} ->
io:format("p2 bad bet return result.. ~w ~n",[Bet]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{code,invalid_bet},{bet,Bet},{bind,P1BuyIn},{raise,PrevRaise},{pot,Pot}]}),
io:format("p2 bad bet return result html ~s~n",[P1DiceResultJsonStr]),
            {html, P1DiceResultJsonStr}
        %_ -> 
        %    io:format("p2_trust not found callback! ~n")
    end;

out(Arg, ["p2_nottrust", "room_pid", Pid, "p2_uid", Player2_uid, "bet",P2Bet]) -> 
    io:format("p2 not trust. ~n",[]),
    player2_nottrustcall(list_to_pid(Pid),Player2_uid,P2Bet),
    receive
        {p2_lose,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot} ->
            P1DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'lose'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1BuyIn},{raise,PrevRaise}]}),
            {html, P1DiceResultJsonStr};
        {p2_win,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot} ->
            P1DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'win'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1BuyIn},{raise,PrevRaise}]}),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, ["p1_trust", "room_pid", Pid, "p1_uid", Player1_uid, "bet",P1Bet]) -> 
    io:format("p1 trust. ~n",[]),
    player1_trustcall(list_to_pid(Pid),Player1_uid,P1Bet),
    receive
        {p1_valid_bet,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Bet,Pot} ->
io:format("p1_trust valid_bet ~n"),
            DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{actual,SortedActualDice},{bind,P1BuyIn},{raise,PrevRaise},{bet,Bet},{pot,Pot}]}),
            {html, DiceResultJsonStr};
        {p1_bad_bet,P1BuyIn,PrevRaise,Bet,Pot} ->
io:format("p1_trust bad_bet ~n"),
            DiceResultJsonStr = mochijson2:encode({struct, [{code,invalid_bet},{bet,Bet},{bind,P1BuyIn},{raise,PrevRaise},{pot,Pot}]}),
            {html, DiceResultJsonStr}
        %_ -> 
        %    io:format("p2_trust not found callback! ~n")
    end;

out(Arg, ["p1_nottrust", "room_pid", Pid, "p1_uid", Player1_uid, "bet",P1Bet]) -> 
    io:format("p1 not trust. ~n",[]),
    player1_nottrustcall(list_to_pid(Pid),Player1_uid,P1Bet),
    receive
        {p1_lose,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot} ->
            DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'lose'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1BuyIn},{raise,PrevRaise}]}),
            {html, DiceResultJsonStr};
        {p1_win,SortedCallDice,SortedActualDice,P1BuyIn,PrevRaise,Pot} ->
            DiceResultJsonStr = mochijson2:encode({struct, [{gameover,'win'},{call,SortedCallDice},{actual,SortedActualDice},{bind,P1BuyIn},{raise,PrevRaise}]}),
            {html, DiceResultJsonStr}
    end;

%when the dice pos is "1", mean that it is reroll, otherwise 0 means no roll
out(Arg, ["p2_rerolldice", "room_pid", Pid, "p2_uid", Player2_uid, "dice_pos",DicePos1flag,DicePos2flag,DicePos3flag,DicePos4flag,DicePos5flag]) -> 
    io:format("p2 reroll. ~n",[]),
    ReRollDicePosList = [list_to_integer(DicePos1flag),list_to_integer(DicePos2flag),list_to_integer(DicePos3flag),list_to_integer(DicePos4flag),list_to_integer(DicePos5flag)],
    player2_reroll(list_to_pid(Pid),Player2_uid,ReRollDicePosList),
    receive
        {p2_dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1BuyIn,P1Raise,P2Bet,Pot} ->
io:format("p2_dicerolled~n"),
            ResultJsonStr = mochijson2:encode({struct, [{roll_pos,ReRollDicePosList},{rolled_dice,NewActualDice},{sorted,NewSortedActualDice},{call,SortedCallDice},{bind,P1BuyIn},{raise,P1Raise},{bet,P2Bet},{pot,Pot}]}),
            {html, ResultJsonStr}
    end;

out(Arg, ["call", "room_pid", Pid, "p2_uid", Player2_uid, "call",D1,D2,D3,D4,D5,"raise",P2Raise]) -> 
    io:format("p2 make call. ~n",[]),
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
            {html, Output}
    end;

out(Arg, ["p1_rerolldice", "room_pid", Pid, "p1_uid", Player1_uid, "dice_pos",DicePos1flag,DicePos2flag,DicePos3flag,DicePos4flag,DicePos5flag]) -> 
    io:format("p2 reroll. ~n",[]),
    ReRollDicePosList = [list_to_integer(DicePos1flag),list_to_integer(DicePos2flag),list_to_integer(DicePos3flag),list_to_integer(DicePos4flag),list_to_integer(DicePos5flag)],
    player1_reroll(list_to_pid(Pid),Player1_uid,ReRollDicePosList),
    receive
        {p1_dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1BuyIn,PrevRaise,Bet,Pot} ->
io:format("p1_dicerolled~n"),
            ResultJsonStr = mochijson2:encode({struct, [{roll_pos,ReRollDicePosList},{rolled_dice,NewActualDice},{sorted,NewSortedActualDice},{call,SortedCallDice},{bind,P1BuyIn},{raise,PrevRaise},{bet,Bet},{pot,Pot}]}),
            {html, ResultJsonStr}
    end;

out(Arg, ["call", "room_pid", Pid, "p1_uid", Player2_uid, "call",D1,D2,D3,D4,D5,"raise",P1Raise]) -> 
    io:format("p1 make call. ~n",[]),
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
            {html, Output}
    end.
