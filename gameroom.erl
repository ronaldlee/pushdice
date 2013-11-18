-module(gameroom).
-include("/home/ubuntu/yaws/include/yaws_api.hrl").
-compile(export_all).
%-record(game_user, {user_id, name, plat_id, plat_type,last_play_date,consecutive_days_played,is_unlocked,coins}).
-define(MAX_DICE_SCORE,90).
%2 days
-define(EXPIRE_GAME_DURATION_IN_MSEC,172800000).

%5minutes
%-define(EXPIRE_GAME_DURATION_IN_MSEC,30000).

-define(STATE,Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults).
-define(CHECK_STATE,pot,Pot,bet,Bet,sorted_call_dice,SortedCallDice,sorted_actual_dice,SortedActualDice,prev_sorted_actual_dice,PrevSortedActualDice,p1_bind,P1Bind, p1_buyin,P1BuyIn, p2_buyin,P2BuyIn,prev_raise,PrevRaise,orig_buyin,OrigBuyIn,all_p1_calls,AllP1Calls,all_p2_calls,AllP2Calls,all_dice_results,AllDiceResults).

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

	[1,1,6,6,6] -> 73;
	[5,5,6,6,6] -> 72;
	[4,4,6,6,6] -> 71;
	[3,3,6,6,6] -> 70;
	[2,2,6,6,6] -> 69;

	[1,1,5,5,5] -> 68;
	[5,5,5,6,6] -> 67;
	[4,4,5,5,5] -> 66;
	[3,3,5,5,5] -> 65;
	[2,2,5,5,5] -> 64;

	[1,1,4,4,4] -> 63;
	[4,4,4,6,6] -> 62;
	[4,4,4,5,5] -> 61;
	[3,3,4,4,4] -> 60;
	[2,2,4,4,4] -> 59;

	[1,1,3,3,3] -> 58;
	[3,3,3,6,6] -> 57;
	[3,3,3,5,5] -> 56;
	[3,3,3,4,4] -> 55;
	[2,2,3,3,3] -> 54;

	[1,1,2,2,2] -> 53;
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

	[5,5,6,6,_] -> 36;
	[4,4,6,6,_] -> 35;
	[3,3,6,6,_] -> 34;
	[2,2,6,6,_] -> 33;

	[4,4,5,5,_] -> 30;
	[3,3,5,5,_] -> 29;
	[2,2,5,5,_] -> 28;

	[3,3,4,4,_] -> 24;
	[2,2,4,4,_] -> 23;

	[2,2,3,3,_] -> 18;

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

	21->[1,1,6,6,9];
	20->[1,1,5,5,9];
	19->[1,1,4,4,9];
	18->[1,1,3,3,9];
	17->[1,1,2,2,9];

	16->[5,5,6,6,9];
	15->[4,4,6,6,9];
	14->[3,3,6,6,9];
	13->[2,2,6,6,9];

	12->[4,4,5,5,9];
	11->[3,3,5,5,9];
	10->[2,2,5,5,9];

	9->[3,3,4,4,9];
	8->[2,2,4,4,9];

	7->[2,2,3,3,9];

	6->[1,9,9,9,9];
	5->[6,9,9,9,9];
	4->[5,9,9,9,9];
	3->[4,9,9,9,9];
	2->[3,9,9,9,9];
	1->[2,9,9,9,9];

	_ -> false 
    end.

diceCompareDescend(Dice1,Dice2) ->
    io:format("dice compare start  ~n"),
    if 
      (Dice1 == 1) and (Dice2 /= 1) -> true; 
      (Dice1 /= 1) and (Dice2 == 1) -> false;
      (Dice1 == 9) and (Dice2 /= 9) -> false; 
      (Dice1 /= 9) and (Dice2 == 9) -> true;
      Dice1 =< Dice2 -> false;
      true -> true 
    end.


findOccur([],OccurCount,DiceVal) ->
    OccurCount;
findOccur([H|Rest],OccurCount,DiceVal) ->
    if 
      H == DiceVal ->
        findOccur(Rest,OccurCount+1,DiceVal);
      true ->
        findOccur(Rest,OccurCount,DiceVal)
    end. 

%group identical dice together, move single dice to the end of the list.
groupOrderedDiceList(OrderedDiceList,NewOrderedDiceList,0) ->
    NewOrderedDiceList;
groupOrderedDiceList(OrderedDiceList,NewOrderedDiceList,ListLength) ->
    [H|Rest] = OrderedDiceList,
    DiceOccur = findOccur(NewOrderedDiceList,0,H),
%io:format("  .. ~w occur:~w ~n",[H,DiceOccur]),
    if 
      DiceOccur == 1 -> %move this to the end of the list
        RemoveOneList = lists:delete(H,NewOrderedDiceList),
%io:format("  .. RemoveOneList:~w ~n",[RemoveOneList]),
        NewOrderedDiceList2 = lists:append(RemoveOneList,[H]),
%io:format("  .. NewOrderedDiceList2:~w ~n",[NewOrderedDiceList2]),
        groupOrderedDiceList(Rest,NewOrderedDiceList2,ListLength-1);
      true -> 
        groupOrderedDiceList(Rest,NewOrderedDiceList,ListLength-1)
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
    %SortedActualDice = lists:sort(diceCompare,NewActualDice),
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
    wait_for_p1_makecall(Player1_uid,Player2_uid,[],SortedActualDice,[],P1Bind,P1BuyIn,P1BuyIn-P1Bind,0,0,0,P1Bind,AllP1Calls,AllP2Calls,AllDiceResults).

wait_for_p1_makecall(?STATE) ->
    receive
        {check, FromPid} -> 
            FromPid ! [Player1_uid,p1,wait_for,makecall,opp_puid,Player2_uid,?CHECK_STATE],
            wait_for_p1_makecall(?STATE);
        {p1,call,ExtPlayer1_uid,FromPid,P1SortedCallDice,raise,P1Raise} ->
            io:format("make call aaa~n",[]),
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_makecall(?STATE);
              true ->    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Need to check if the call is valid!!!  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
io:format("make call ~w~n",[P1SortedCallDice]),
              IsValid = getDiceScore(P1SortedCallDice),
              case IsValid of 
                false ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_makecall(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,[],P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,AllDiceResults);
                _ ->
io:format("dice score ~w~n",[IsValid]),
                    FromPid ! {valid_call,Pot},
                    NewPot = Pot+P1Raise,

                    {ok, C} = eredis:start_link(),
                    PushNotiData = io_lib:format("{\"action\":\"makecall\", \"p1\":\"~s\", \"p2\":\"~s\"}",[Player1_uid,Player2_uid]),
                    eredis:q(C, ["RPUSH", "PUSHDICE_IOS_PUSH_NOTI", PushNotiData]),
                    eredis:stop(C),

                    %append P1SortedCallDice to ALLP1Calls 
                    NewAllP1Calls = lists:append(AllP1Calls,[P1SortedCallDice]),
                    wait_for_p2_acceptgame(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,[],P1Bind,OrigBuyIn,P1BuyIn-P1Raise,P2BuyIn,P1Raise,Bet,NewPot,NewAllP1Calls,AllP2Calls,AllDiceResults)
              end
            end;
        _ -> 
            io:format("whatt!! ~n",[])
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, lose, Player2_uid, win,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

wait_for_p2_acceptgame(?STATE) ->
    io:format("wait for p2 acceptgame ~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player2_uid,p2,wait_for,accept_game,opp_puid,Player1_uid,?CHECK_STATE],
            wait_for_p2_acceptgame(?STATE);
        {p2,acceptgame,ExtPlayer2_uid,FromPid,P2Bind,NewP2BuyIn} ->
io:format("p2 ACCEPT ~n"),
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_acceptgame(?STATE);
              true ->    

                %register this user to the p1's game session list
                Player1FriendsGamesKey = io_lib:format("pfg_~s",[Player1_uid]),
                Player2FriendsGamesKey = io_lib:format("pfg_~s",[Player2_uid]),

io:format("keys: p1: ~s; ~s~n",[Player1FriendsGamesKey,Player2FriendsGamesKey]),

                {ok, C} = eredis:start_link(),
                eredis:q(C, ["SADD", Player1FriendsGamesKey, Player2_uid]),
                eredis:q(C, ["SADD", Player2FriendsGamesKey, Player1_uid]),
                eredis:stop(C),

io:format("p2 wait for trust or not.. ~n"),
                SortedCallDiceScore = getDiceScore(SortedCallDice),
                MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
                NewPot = Pot + P2Bind,
                FromPid ! {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1Bind, "raise",PrevRaise,"pot",NewPot,"sorted_call_dice_score",SortedCallDiceScore},
                wait_for_p2_trust_or_not(Player1_uid,Player2_uid,SortedCallDice,SortedActualDice,[],P1Bind,OrigBuyIn,P1BuyIn,NewP2BuyIn-P2Bind,PrevRaise,Bet,NewPot,AllP1Calls,AllP2Calls,AllDiceResults)
            end
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, win , Player2_uid, lose,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

wait_for_p2_findcall(?STATE) ->
    io:format("wait for p2 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player2_uid,p2,wait_for,find_call,opp_puid,Player1_uid,?CHECK_STATE],
            wait_for_p2_findcall(?STATE);
        {p2,findcall,ExtPlayer2_uid,FromPid} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_findcall(?STATE);
              true ->    
                SortedCallDiceScore = getDiceScore(SortedCallDice),
                MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
                FromPid ! {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1Bind, "raise",PrevRaise,"pot",Pot,"sorted_call_dice_score",SortedCallDiceScore},
                wait_for_p2_trust_or_not(?STATE)
            end
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, win , Player2_uid, lose,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

wait_for_p1_findcall(?STATE) ->
    io:format("wait for p1 find call~n",[]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player1_uid,p1,wait_for,find_call,opp_puid,Player2_uid,?CHECK_STATE],
            wait_for_p1_findcall(?STATE);
        {p1,findcall,ExtPlayer1_uid,FromPid} ->
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_findcall(?STATE);
              true ->    
                SortedCallDiceScore = getDiceScore(SortedCallDice),
                MinSortedCallDice = getDiceCombByScore(SortedCallDiceScore+1),
                FromPid ! {p2,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind",P1Bind, "raise",PrevRaise,"pot",Pot,"sorted_call_dice_score",SortedCallDiceScore},
                wait_for_p1_trust_or_not(?STATE)
            end
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, lose , Player2_uid, win,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

%append wildcard "9" to fill up the list to lenght 5.
appendWildCardToList(TargetList,0) -> TargetList;
appendWildCardToList(TargetList,Count) -> 
    NewTargetList = lists:append(TargetList,[9]),
    NewCount = Count - 1,
    appendWildCardToList(NewTargetList,NewCount).


wait_for_p2_trust_or_not(?STATE) ->
io:format("wait for p2 trust or not, call: ~w; actual: ~w ~n",[SortedCallDice,SortedActualDice]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player2_uid,p2,wait_for,trust_or_not,opp_puid,Player1_uid,?CHECK_STATE],
            wait_for_p2_trust_or_not(?STATE);
        {p2,trust,ExtPlayer2_uid,FromPid,bet,NewBet} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_trust_or_not(?STATE);
              true ->    
io:format("trust! ~w, ~w ~n",[P1Bind,PrevRaise]),
            %check if p2 bet matches p1's, if not return error
io:format("trust P1 PrevRaise: ~w, P2Bet: ~w  ~n",[PrevRaise,Bet]),
              if 
                (NewBet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p2_trust_or_not(?STATE);
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
                wait_for_p2_trust_or_not(?STATE);
              true ->    
                if
                  (NewBet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p2_trust_or_not(?STATE);
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
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,false);
                        true ->
                            io:format("p1 call NOT match actual! p2 win.. ~n"),
                            %update p2 player's coin by adding pot
                            FromPid ! {p2,win,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,NewPot},
                            game_over(Player1_uid,lose,Player2_uid,win,
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,false)
                    end
                  end
            end
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, win, Player2_uid, lose,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

wait_for_p1_trust_or_not(?STATE) ->
io:format("wait for p1 trust or not, call: ~w; actual: ~w ~n",[SortedCallDice,SortedActualDice]),
    receive
        {check, FromPid} -> 
            FromPid ! [Player1_uid,p1,wait_for,trust_or_not,opp_puid,Player2_uid,?CHECK_STATE],
            wait_for_p1_trust_or_not(?STATE);
        {p1,trust,ExtPlayer1_uid,FromPid,bet,NewBet} ->
io:format("p1_trust receive ~n",[]),
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_trust_or_not(?STATE);
              true ->    
io:format("p1_trust, bet: ~w, prevraise: ~w~n",[Bet,PrevRaise]),
            %check if p1 bet matches p2's, if not return error
                if 
                  (NewBet < PrevRaise) ->
                    io:format("p1 bad bet! ~n"),
                    FromPid ! {p1,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p1_trust_or_not(?STATE);
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
                wait_for_p1_trust_or_not(?STATE);
              true ->    
                if
                  (NewBet < PrevRaise) ->
                    io:format("p2 bad bet! ~n"),
                    FromPid ! {p2,bad_bet,P1Bind,PrevRaise,NewBet,Pot},
                    wait_for_p2_trust_or_not(?STATE);
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
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,false);
                        true ->
                            io:format("p2 call NOT match actual! p1 win.. ~n"),
                            %update p2 player's coin by adding pot
                            FromPid ! {p1,win,SortedCallDice,SortedActualDice,P1Bind,PrevRaise,Pot},
                            game_over(Player1_uid,win,Player2_uid,lose,
                                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,false)
                    end
                end
            end
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, lose, Player2_uid, win,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

game_over(Player1_uid, P1_result, Player2_uid, P2_result,
          Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,IsExpire) ->
    receive 
        {check, FromPid} ->
          FromPid ! [game_over,Player1_uid, P1_result, Player2_uid, P2_result,Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,IsExpire],
          game_over(Player1_uid,P1_result,Player2_uid,P2_result,Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,IsExpire);
        {kill, FromPid} ->
          true;
        _ ->
          game_over(Player1_uid,P1_result,Player2_uid,P2_result,Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,IsExpire)
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


wait_for_p2_pick_dice_to_roll(?STATE) ->
io:format("wait_for_p2_pick_dice_to_roll ~n"),
    receive
        {check, FromPid} ->
            FromPid ! [Player2_uid,p2,wait_for,rerolldice,opp_puid,Player1_uid,?CHECK_STATE],
            wait_for_p2_pick_dice_to_roll(?STATE);
        {p2,reroll,ExtPlayer2_uid,FromPid,ReRollDicePosList} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_pick_dice_to_roll(?STATE);
              true ->    
                NewActualDice = rerollDice(SortedActualDice,ReRollDicePosList,[]),
                %sort the result before returning
                NewSortedActualDice = lists:sort(NewActualDice),

                NewAllDiceResults = lists:append(AllDiceResults,[NewSortedActualDice]),
io:format("p2_reroll NewSortedActualDice: ~w~n",[NewSortedActualDice]),
                FromPid ! {p2,dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1Bind,PrevRaise,Bet,Pot},
                wait_for_p2_call(Player1_uid,Player2_uid,SortedCallDice,NewSortedActualDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,NewAllDiceResults)
            end
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, win, Player2_uid, lose,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

wait_for_p1_pick_dice_to_roll(?STATE) ->
io:format("wait_for_p1_pick_dice_to_roll ~n"),
    receive
        {check, FromPid} ->
            FromPid ! [Player1_uid,p1,wait_for,rerolldice,opp_puid,Player2_uid,?CHECK_STATE],
            wait_for_p1_pick_dice_to_roll(?STATE);
        {p1,reroll,ExtPlayer1_uid,FromPid,ReRollDicePosList} ->
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_pick_dice_to_roll(?STATE);
              true ->    
                NewActualDice = rerollDice(SortedActualDice,ReRollDicePosList,[]),
                %sort the result before returning
                NewSortedActualDice = lists:sort(NewActualDice),
                NewAllDiceResults = lists:append(AllDiceResults,[NewSortedActualDice]),
io:format("p1_reroll NewSortedActualDice: ~w~n",[NewSortedActualDice]),
                FromPid ! {p1,dicerolled,SortedCallDice,NewActualDice,NewSortedActualDice,P1Bind,PrevRaise,Bet,Pot},
                wait_for_p1_call(Player1_uid,Player2_uid,SortedCallDice,NewSortedActualDice,SortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn,PrevRaise,Bet,Pot,AllP1Calls,AllP2Calls,NewAllDiceResults)
            end
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, lose, Player2_uid, win,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

wait_for_p2_call(?STATE) ->
    io:format("wait_for_p2_call~n"),
    receive
        {check, FromPid} ->
            if is_pid(FromPid) -> io:format("from is pid!~n"); true -> io:format("from is not pid!~n") end,

            FromPid ! [Player2_uid,p2,wait_for,call,opp_puid,Player1_uid,?CHECK_STATE],
            wait_for_p2_call(?STATE);
        {p2,call,ExtPlayer2_uid,FromPid,P2SortedCallDice,raise,P2Raise} ->
            if 
              (ExtPlayer2_uid /= Player2_uid) -> 
                FromPid ! invalid_player,
                wait_for_p2_call(?STATE);
              true ->    
io:format("p2_call SortedActualDice: ~w~n",[SortedActualDice]),
                %if the new call is "smaller" than the previous call -> error
                %make sure P2SortedCallDice is > SortedCallDice
                PrevSortedCallDiceScore = getDiceScore(SortedCallDice),
                P2SortedCallDiceScore = getDiceScore(P2SortedCallDice),

                if 
                (P2SortedCallDiceScore == false) ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p2_call(?STATE);
                (P2SortedCallDiceScore == ?MAX_DICE_SCORE) ->
                    %what will happen??
                    NewPot = Pot + P2Raise,
                    NewPrevRaise = P2Raise,

                    NewAllP2Calls = lists:append(AllP2Calls,[P2SortedCallDice]),
                    FromPid ! {valid_call,NewPot},

                    {ok, C} = eredis:start_link(),
                    PushNotiData = io_lib:format("{\"action\":\"p2_call\", \"p1\":\"~s\", \"p2\":\"~s\"}",[Player1_uid,Player2_uid]),
                    eredis:q(C, ["RPUSH", "PUSHDICE_IOS_PUSH_NOTI", PushNotiData]),
                    eredis:stop(C),

                    wait_for_p1_findcall(Player1_uid,Player2_uid,P2SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn-P2Raise,NewPrevRaise,Bet,NewPot,AllP1Calls,NewAllP2Calls,AllDiceResults);
                (P2SortedCallDiceScore > PrevSortedCallDiceScore) ->
                    io:format("P2 call is greater than prev call ~w, prev: ~w ~n",[P2SortedCallDiceScore,PrevSortedCallDiceScore]),
                    %valid call
                    NewPot = Pot + P2Raise,
                    NewPrevRaise = P2Raise,

                    NewAllP2Calls = lists:append(AllP2Calls,[P2SortedCallDice]),
                    FromPid ! {valid_call,NewPot},

                    {ok, C} = eredis:start_link(),
                    PushNotiData = io_lib:format("{\"action\":\"p2_call\", \"p1\":\"~s\", \"p2\":\"~s\"}",[Player1_uid,Player2_uid]),
                    eredis:q(C, ["RPUSH", "PUSHDICE_IOS_PUSH_NOTI", PushNotiData]),
                    eredis:stop(C),

                    wait_for_p1_findcall(Player1_uid,Player2_uid,P2SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn,P2BuyIn-P2Raise,NewPrevRaise,Bet,NewPot,AllP1Calls,NewAllP2Calls,AllDiceResults);
                true ->
                    io:format("Invalid P2 call is less than prev call ~w, prev: ~w ~n",[P2SortedCallDiceScore,PrevSortedCallDiceScore]),
                    FromPid ! {invalid_call,Pot},
                    wait_for_p2_call(?STATE) 
                end
            end;
        true -> 
            wait_for_p2_call(?STATE) 
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, win, Player2_uid, lose,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
    end.

wait_for_p1_call(?STATE) ->
    io:format("wait_for_p1_call~n"),
    receive
        {check, FromPid} ->
io:format("wait_for_p1_call check:from ~w~n",[FromPid]),
            if is_pid(FromPid) -> io:format("from is pid!~n"); true -> io:format("from is not pid!~n") end,
            FromPid ! [Player1_uid,p1,wait_for,call,opp_puid,Player2_uid,?CHECK_STATE],
            wait_for_p1_call(?STATE);
        {p1,call,ExtPlayer1_uid,FromPid,P1SortedCallDice,raise,P1Raise} ->
            if 
              (ExtPlayer1_uid /= Player1_uid) -> 
                FromPid ! invalid_player,
                wait_for_p1_call(?STATE);
              true ->    
io:format("p1_call SortedActualDice: ~w~n",[SortedActualDice]),
                %if the new call is "smaller" than the previous call -> error
                %make sure P2SortedCallDice is > SortedCallDice
                PrevSortedCallDiceScore = getDiceScore(SortedCallDice),
                P1SortedCallDiceScore = getDiceScore(P1SortedCallDice),

                if 
                (P1SortedCallDiceScore == false) ->
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_call(?STATE);
                (P1SortedCallDiceScore == ?MAX_DICE_SCORE) ->
                    %what will happen??
                    NewPot = Pot + P1Raise,
                    NewPrevRaise = P1Raise,

                    NewAllP1Calls = lists:append(AllP1Calls,[P1SortedCallDice]),
                    FromPid ! {valid_call,NewPot},

                    {ok, C} = eredis:start_link(),
                    PushNotiData = io_lib:format("{\"action\":\"p1_call\", \"p1\":\"~s\", \"p2\":\"~s\"}",[Player1_uid,Player2_uid]),
                    eredis:q(C, ["RPUSH", "PUSHDICE_IOS_PUSH_NOTI", PushNotiData]),
                    eredis:stop(C),

                    wait_for_p2_findcall(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn-P1Raise,P2BuyIn,NewPrevRaise,Bet,NewPot,NewAllP1Calls,AllP2Calls,AllDiceResults);
                (P1SortedCallDiceScore > PrevSortedCallDiceScore) ->
                    io:format("P1 call is greater than prev call ~w, prev: ~w ~n",[P1SortedCallDiceScore,PrevSortedCallDiceScore]),
                    %valid call
                    NewPot = Pot + P1Raise,
                    NewPrevRaise = P1Raise,

                    NewAllP1Calls = lists:append(AllP1Calls,[P1SortedCallDice]),
                    FromPid ! {valid_call,NewPot},

                    {ok, C} = eredis:start_link(),
                    PushNotiData = io_lib:format("{\"action\":\"p1_call\", \"p1\":\"~s\", \"p2\":\"~s\"}",[Player1_uid,Player2_uid]),
                    eredis:q(C, ["RPUSH", "PUSHDICE_IOS_PUSH_NOTI", PushNotiData]),
                    eredis:stop(C),

                    wait_for_p2_findcall(Player1_uid,Player2_uid,P1SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,OrigBuyIn,P1BuyIn-P1Raise,P2BuyIn,NewPrevRaise,Bet,NewPot,NewAllP1Calls,AllP2Calls,AllDiceResults);
                true ->
                    io:format("Invalid P1 call is less than prev call ~w, prev: ~w ~n",[P1SortedCallDiceScore,PrevSortedCallDiceScore]),
                    FromPid ! {invalid_call,Pot},
                    wait_for_p1_call(?STATE) 
                end
            end;
        true -> 
io:format("wait_for_p1_call others..."),
            wait_for_p1_call(?STATE)
    after
        ?EXPIRE_GAME_DURATION_IN_MSEC ->        
            game_over(Player1_uid, lose, Player2_uid, win,
                      Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn,true)
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
            [IsExpire|Rest15] = Rest14,
%Pot,Bet,SortedCallDice,SortedActualDice,PrevSortedActualDice,P1Bind,P1BuyIn,P2BuyIn,PrevRaise,OrigBuyIn

            %deregister p1 p2 game list
            Player1FriendsGamesKey = io_lib:format("pfg_~s",[Player1_uid]),
            Player2FriendsGamesKey = io_lib:format("pfg_~s",[Player2_uid]),

            {ok, C} = eredis:start_link(),
            eredis:q(C, ["SREM", Player1FriendsGamesKey, Player2_uid]),
            eredis:q(C, ["SREM", Player2FriendsGamesKey, Player1_uid]),
            eredis:stop(C),

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
            [opp_puid|Rest4] = Rest3,
            [OppPuid|Rest5] = Rest4,
            [pot|Rest6] = Rest5,
            [CurrentPot|Rest7] = Rest6,
            [bet|Rest8] = Rest7,
            [CurrentBet|Rest9] = Rest8,
            [sorted_call_dice|Rest10] = Rest9,
            [SCalledDice|Rest11] = Rest10,
            [sorted_actual_dice|Rest12] = Rest11,
            [SActualDice|Rest13] = Rest12,
            [prev_sorted_actual_dice|Rest14] = Rest13,
            [PrevSActualDice|Rest15] = Rest14,
            [p1_bind|Rest16] = Rest15,
            [Bind|Rest17] = Rest16,
            [p1_buyin|Rest18] = Rest17,
            [P1_Buyin|Rest19] = Rest18,
            [p2_buyin|Rest20] = Rest19,
            [P2_Buyin|Rest21] = Rest20,
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
        {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1Bind, "raise", P1Raise,"pot",Pot,"sorted_call_dice_score",SortedCallDiceScore} ->
io:format("p1_calldice. ~n",[]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1Bind},{raise,P1Raise},{pot,Pot},{dice_score,SortedCallDiceScore}]}),
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
        {p1,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1Bind, "raise", P1Raise,"pot",Pot,"sorted_call_dice_score",SortedCallDiceScore} ->
    io:format("p1_calldice. ~n",[]),
            P1DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1Bind},{raise,P1Raise},{pot,Pot},{dice_score,SortedCallDiceScore}]}),
            {html, P1DiceResultJsonStr}
    end;

out(Arg, [Pid, "find_call", "p1_uid", Player1_uid]) -> 
    io:format("p1 find out p2 call. ~n",[]),
    player1_findcall(list_to_pid(Pid),Player1_uid),
    receive
        {p2,"calldice", SortedCallDice, "min_call", MinSortedCallDice, "p1_bind", P1Bind, "raise", P1Raise,"pot",Pot,"sorted_call_dice_score",SortedCallDiceScore} ->
    io:format("p2_calldice. ~n",[]),
            P2DiceResultJsonStr = mochijson2:encode({struct, [{call,SortedCallDice},{min,MinSortedCallDice},{bind,P1Bind},{raise,P1Raise},{pot,Pot},{dice_score,SortedCallDiceScore}]}),
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

out(Arg, ["testsort"])->
    io:format("test sort start ~n"),
    SortedActualDice = lists:sort(fun diceCompareDescend/2,[3,2,1,2,4]),
    %SortedActualDice = lists:sort(diceCompare,[]),
    io:format("test sort after ~n"),
    io:format("test sort ~w~n",[SortedActualDice]),

    Output = mochijson2:encode({struct, [ {status,ok} ]}),

    {html, Output};

out(Arg, ["testgroup"])->
    io:format("test group~n"),
    %NewList = groupOrderedDiceList([1,1,3,2,2],[1,1,3,2,2],5),
    NewList = groupOrderedDiceList([2,3,4,4,9],[2,3,4,4,9],5),
    io:format("test group list: ~w~n",[NewList]),

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
