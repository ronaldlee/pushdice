<?php

function showRoom() {
//get rooms
$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/11");
echo "****** p1 rooms: $result \n";
echo "\n";

$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/22");
echo "****** p2 rooms: $result \n";
echo "\n";
}

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/11/p2_uid/22/bind/5/buyin/1000");
echo "p1 create game and roll dice: $result \n";
echo "\n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}

//p1 make call
$raise=2;
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/makecall/p1_uid/11/call/2/2/3/3/9/raise/$raise");
echo "p1 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

showRoom();

