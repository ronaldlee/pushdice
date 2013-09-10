<?php

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/11/p2_uid/22");
echo "p1 create game: $result \n";
echo "\n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}


//get rooms
$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/11");
echo "p1 rooms: $result \n";
echo "\n";

$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/22");
echo "p2 rooms: $result \n";
echo "\n";

$result = file_get_contents("http://54.213.19.254/gameroom/del/uid/11");
echo "p1 rooms: $result \n";
echo "\n";

$result = file_get_contents("http://54.213.19.254/gameroom/del/uid/22");
echo "p2 rooms: $result \n";
echo "\n";
?>
