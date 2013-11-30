<?php
function showRoom($p1) {
//get rooms
$result = file_get_contents("http://54.213.19.254/gameroom/list/uid/$p1");
echo "****** p1 rooms: $result \n";
echo "\n";

}

$accesstoken = "CAACEdEose0cBAPMZBVrXUF4yRme8mGZB63Y010GArR1EQaqjkiuv1OAKrxxDZAXPOpYZBl4051FYcznAS1LMIOWKMwpSslZCBm1gdbmOhVF2Lclm57JoCnKrM4agbZA9OizoZCnrXtD2ewZB6wt3ltuNtGk38UnG2JVORLTTtMta74ZBujPnQOOx8ObV0F9UCCdsZD";

$total = 1;
$user = 1234567;

for ($i=0; $i <$total; $i++) {
  $result = file_get_contents("http://54.213.19.254/pushdice/login/username/hellokitty/id/$user/type/fb/accesstoken/$accesstoken/ios_pushtoken/fake_push_token");
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

//  showRoom($user);
}


