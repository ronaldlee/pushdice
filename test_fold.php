<?php

/*
| user_id | name    | coins | plat_id         | plat_type | fb_accesstoken | create_date         | last_play_date      | consecutive_days_played | is_unlocked | ios_push_token |
+---------+---------+-------+-----------------+-----------+----------------+---------------------+---------------------+-------------------------+-------------+----------------+
|      57 | Boo1    |     0 | 12929292        | fb        | lsd            | 2013-08-22 04:03:59 | 2013-08-22 04:05:14 |                       1 |           0 |                |
|      58 | Ace Dev |     0 | 100001100774832 | fb        |                | 2013-08-26 00:32:41 | 2013-11-09 19:29:57 |                       1 |           0 | (null)         |
+---------+---------+-------+-----------------+-----------+----------------+---------------------+---------------------+-------------------------+-------------+----------------+
*/
$p1="58"; //Ace Dev
//$p2="59"; //Ricky Lee
$p2="57"; //Boo1

echo "P1: $p1: Ace Dev\n";
echo "P2: $p2: Boo1\n";

/*
$p1="11";
$p2="22";
*/


function showRoom($p1,$p2) {
$is_show=true;
//get rooms
$comb_result = array();
$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/$p1");

$comb_result['p1'] = json_decode($result,true);
if ($is_show) {
echo "****** p1 rooms: $result \n";
echo "\n";
}

$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/$p2");
$comb_result['p2'] = json_decode($result,true);
if ($is_show) {
echo "****** p2 rooms: $result \n";
echo "\n";
}

return $comb_result;
}

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/$p1/p2_uid/$p2/bind/10/buyin/1000");
echo "p1 create game and roll dice: $result \n";
echo "\n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}
else {
echo "Fail to init game room, probably not enough money to pay for buyin.\n";
exit -1;
}

//p1 make call
$raise=2;
//$result = file_get_contents("http://54.213.19.254/gameroom/$pid/makecall/p1_uid/$p1/call/1/4/4/9/9/raise/$raise");
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/makecall/p1_uid/$p1/call/1/9/9/9/9/raise/$raise");
echo "p1 make call: $result \n";
echo "\n";
$json = json_decode($result,true);

//p2 accept game 
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/accept_game/p2_uid/$p2/bind/10/buyin/1000");
echo "p2 accept game: $result \n";
echo "\n";
$json = json_decode($result,true);
echo "p2 accept game json: " . json_encode($json) . "\n";

if (isset($json['code']) && $json['code'] == "-1") {

echo "Fail to accept game probably not enough coins \n";
exit -1;
}

//p2 fold
$result = file_get_contents("http://54.213.19.254/gameroom/$pid/fold/p2_uid/$p2");
echo "p2 fold: $result \n";
echo "\n";
?>
