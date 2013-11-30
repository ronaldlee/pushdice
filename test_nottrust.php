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

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/$p1/p2_uid/$p2/bind/5/buyin/1000");
echo "p1 create game and roll dice: $result \n";
echo "\n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}

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
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/nottrust/p2_uid/$p2/bet/10");
echo "p2 not trust: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom($p1,$p2);


?>
