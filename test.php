<?php

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/11/p2_uid/22");
echo "p1 create game: $result \n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}

//P2 join room
$result = file_get_contents("http://54.213.19.254/gameroom/join/room_pid/$pid/uid/22");
echo "p2 join: $result \n";
$json = json_decode($result,true);

$buyin=5;
//p1 roll dice
$result = file_get_contents("http://54.213.19.254/gameroom/rolldice/room_pid/$pid/p1_uid/11/buy_in/$buyin");
echo "p1 rolldice : $result \n";
$json = json_decode($result,true);

//p1 make call
$raise=2;
$result = file_get_contents("http://54.213.19.254/gameroom/makecall/room_pid/$pid/p1_uid/11/call/2/2/3/2/3/raise/$raise");
echo "p1 make call: $result \n";
$json = json_decode($result,true);

//p2 receive p1 call
$result = file_get_contents("http://54.213.19.254/gameroom/get_p1_call/room_pid/$pid/p2_uid/22");
echo "p2 receive p1: $result \n";
$json = json_decode($result,true);

//p2 trust
$result = file_get_contents("http://54.213.19.254/gameroom/p2_trust/room_pid/$pid/p2_uid/22/p2_bet/10");
echo "p2 trust: $result \n";
$json = json_decode($result,true);
?>
