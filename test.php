<?php

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/11/p2_uid/22");
echo "p1 create game: $result \n";
echo "\n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}

//P2 join room
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/join/uid/22");
echo "p2 join: $result \n";
echo "\n";
$json = json_decode($result,true);

$buyin=5;
//p1 roll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rolldice/p1_uid/11/buy_in/$buyin");
echo "p1 rolldice : $result \n";
echo "\n";
$json = json_decode($result,true);

//p1 make call
$raise=2;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/makecall/p1_uid/11/call/2/2/3/3/9/raise/$raise");
echo "p1 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

/*
$raise=2;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p1_uid/22/call/3/3/3/3/9/raise/$raise");
echo "p1 make call: $result \n";
$json = json_decode($result,true);
*/

//p2 receive p1 call
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/get_call/p2_uid/22");
echo "p2 receive p1: $result \n";
echo "\n";
$json = json_decode($result,true);


//p2 not trust
/*
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/nottrust/p2_uid/22/bet/10");
echo "p2 not trust: $result \n";
$json = json_decode($result,true);
*/


//p2 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p2_uid/22/bet/10");
echo "p2 trust: $result \n";
echo "\n";
$json = json_decode($result,true);

//p2 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/22/dice_pos/0/0/1/0/1");
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/22/dice_pos/0/1/1/1/1");
echo "p2 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

//p2 make call
$raise=12;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p2_uid/22/call/2/2/2/2/9/raise/$raise");
echo "p2 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

//p1 receive p2 call
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/get_call/p1_uid/11");
echo "p1 receive p2: $result \n";
echo "\n";
$json = json_decode($result,true);

//p1 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p1_uid/11/bet/20");
echo "p1 trust: $result \n";
echo "\n";
$json = json_decode($result,true);

//p1 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p1_uid/11/dice_pos/0/0/1/0/1");
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p1_uid/11/dice_pos/0/1/1/1/1");
echo "p1 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

//p1 make call
$raise=2;
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p1_uid/22/call/2/2/2/3/9/raise/$raise");
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p1_uid/22/call/3/3/3/3/9/raise/$raise");
echo "p1 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

//p2 receive p1 call
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/get_call/p2_uid/22");
echo "p2 receive p1: $result \n";
echo "\n";
$json = json_decode($result,true);

//p2 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p2_uid/22/bet/18");
echo "p2 trust: $result \n";
echo "\n";
$json = json_decode($result,true);
if (isset($json['code']) && $json['code']=="invalid_bet") {
exit;
}

//p2 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/22/dice_pos/0/0/1/0/1");
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p2_uid/22/dice_pos/0/1/1/1/1");
echo "p2 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

//p2 make call
$raise=12;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/call/p2_uid/22/call/4/4/4/4/9/raise/$raise");
echo "p2 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

$json = json_decode($result,true);
if (isset($json['code']) && $json['code']=="invalid_call") {
exit;
}

//p1 receive p2 call
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/get_call/p1_uid/11");
echo "p1 receive p2: $result \n";
echo "\n";
$json = json_decode($result,true);

//p1 not trust
/*
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/nottrust/p1_uid/11/bet/10");
echo "p1 not trust: $result \n";
$json = json_decode($result,true);
*/

//p1 trust
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/trust/p1_uid/11/bet/20");
echo "p1 trust: $result \n";
echo "\n";
$json = json_decode($result,true);

//p1 reroll dice
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/rerolldice/p1_uid/11/dice_pos/1/0/0/1/0");
echo "p1 reroll: $result \n";
echo "\n";
$json = json_decode($result,true);

?>
