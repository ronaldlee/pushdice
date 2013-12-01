<?php
function showRoom($p) {
//get rooms
$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/$p");
echo "****** p rooms: $result \n";
echo "\n";
}

function login($name,$uid,$accesstoken) {
  $result = file_get_contents("http://54.213.19.254/pushdice/login/username/$name/id/$uid/type/fb/accesstoken/$accesstoken/ios_pushtoken/fake_push_token");
  echo "login: $result \n";
  echo "\n";
  $json = json_decode($result,true);

  $session = $json['session'];
  echo "session: $session\n";

  $result = file_get_contents("http://54.213.19.254/pushdice/user/session/$session");
  echo "user: $result \n";
  echo "\n";
  $json = json_decode($result,true);

  $result = file_get_contents("http://54.213.19.254/pushdice/friends/accesstoken/$accesstoken/session/$session");
  echo "friends: $result \n";
  echo "\n";

  return $result;
}

$accesstoken1 = "CAACEdEose0cBAK4hZAAlo6xw5l1QvV2yATvq16u8ps2jr4ZCzh0nI3tmN5HZCGZBG9LdlIpEt6iSDkNm1rNXnJWzH6QNgFNTdULeBYrtjXJKZAwoG0o64uC7hdxp12fAJneWZBmZBE8bPJ55V4bzU4jnoptIr8siFtaVuHE9EzEoyyJ6ZCWcDzDQzvLou7vUU9AZD";

$accesstoken2 = "CAACEdEose0cBAKbZCGNZCSXo9S9eJrPHkffZAaqZBqqUJ104ovqb9qlZAyE5uPXrfHe2NErzZBkESRjttF4lyGZAIyex7a9x2YmZBWh9gb2nR69e85odil5BeVTmG8SIXRZCUTGFJ5OSvDV5y3iqux8PWScY6IgzfiOrqZAvRpMMZBlIWdlBBGdpTZB8cFjykTZBMKN0ZD";

$total = 1;
$p1 = 674859815;
$p2 = 100000129647227;


$friends1 = login('ronking',$p1,$accesstoken1);
$friends2 = login('imginaryfriend',$p2,$accesstoken2);


//  showRoom($user);

$result = file_get_contents("http://54.213.19.254/gameroom/init/p1_uid/$p1/p2_uid/$p2/bind/5/buyin/1000");
echo "^^^ init: $result \n";
$json = json_decode($result,true);
$pid = null;
if (isset($json['pid'])) {
    $pid = $json['pid'];  
}

$raise=2;

$result = file_get_contents("http://54.213.19.254/gameroom/$pid/makecall/p1_uid/$p1/call/4/4/1/9/9/raise/$raise");
echo "^^^ makecall: $result \n";


$result = file_get_contents("http://54.213.19.254/gameroom/$pid/accept_game/p2_uid/$p2/bind/10/buyin/1000");
echo "^^^ accept_game: $result \n";


echo "######################################## \n";
echo "######################################## \n";
echo "######################################## \n";

$friends1 = login('ronking',$p1,$accesstoken1);
$friends2 = login('imginaryfriend',$p2,$accesstoken2);


