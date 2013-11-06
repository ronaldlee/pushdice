<?php

$p1="58";
$p2="57";

/*
$p1="11";
$p2="22";
*/


function showRoom($p1,$p2) {
//get rooms
$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/$p1");
echo "****** p1 rooms: $result \n";
echo "\n";

$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/$p2");
echo "****** p2 rooms: $result \n";
echo "\n";
}

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/$p1/p2_uid/$p2/bind/10/buyin/1000");
echo "p1 create game and roll dice: $result \n";
echo "\n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}

showRoom($p1,$p2);

//p1 make call
$raise=2;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/makecall/p1_uid/$p1/call/1/1/1/9/9/raise/$raise");
echo "p1 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p2 accept game 
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/accept_game/p2_uid/$p2/bind/10/buyin/1000");
echo "p2 accept game: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p2 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p2_uid/$p2/bet/10");
echo "p2 trust: $result \n";
echo "\n";
$json = json_decode($result,true);

//showRoom($p1,$p2);

//p2 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/$p2/dice_pos/0/0/1/0/1");
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/$p2/dice_pos/0/1/1/1/1");
echo "p2 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p2 make call
$raise=12;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p2_uid/$p2/call/2/2/2/2/9/raise/$raise");
echo "p2 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p1 receive p2 call
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/find_call/p1_uid/$p1");
echo "p1 receive p2: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p1 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p1_uid/$p1/bet/20");
echo "p1 trust: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p1 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p1_uid/$p1/dice_pos/0/0/1/0/1");
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p1_uid/$p1/dice_pos/0/1/1/1/1");
echo "p1 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p1 make call
$raise=2;
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p1_uid/$p2/call/2/2/2/3/9/raise/$raise");
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p1_uid/$p1/call/3/3/3/3/9/raise/$raise");
echo "p1 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p2 receive p1 call
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/find_call/p2_uid/$p2");
echo "p2 receive p1: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p2 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p2_uid/$p2/bet/18");
echo "p2 trust: $result \n";
echo "\n";
$json = json_decode($result,true);
if (isset($json['code']) && $json['code']=="invalid_bet") {
exit;
}

showRoom($p1,$p2);

//p2 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/$p2/dice_pos/0/0/1/0/1");
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/$p2/dice_pos/0/1/1/1/1");
echo "p2 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p2 make call
$raise=12;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p2_uid/$p2/call/4/4/4/4/9/raise/$raise");
echo "p2 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

$json = json_decode($result,true);
if (isset($json['code']) && $json['code']=="invalid_call") {
exit;
}

//p1 receive p2 call
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/find_call/p1_uid/$p1");
echo "p1 receive p2: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p1 not trust
/*
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/nottrust/p1_uid/$p1/bet/10");
echo "p1 not trust: $result \n";
$json = json_decode($result,true);
*/

//p1 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p1_uid/$p1/bet/20");
echo "p1 trust: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

//p1 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p1_uid/$p1/dice_pos/1/0/0/1/0");
echo "p1 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);

?>
