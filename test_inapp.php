<?php

$user = 1234567;

$accesstoken = "CAACEdEose0cBAPMZBVrXUF4yRme8mGZB63Y010GArR1EQaqjkiuv1OAKrxxDZAXPOpYZBl4051FYcznAS1LMIOWKMwpSslZCBm1gdbmOhVF2Lclm57JoCnKrM4agbZA9OizoZCnrXtD2ewZB6wt3ltuNtGk38UnG2JVORLTTtMta74ZBujPnQOOx8ObV0F9UCCdsZD";

$result = file_get_contents("http://54.213.19.254/pushdice/login/username/hellokitty/id/$user/type/fb/accesstoken/$accesstoken/ios_pushtoken/fake_push_token");

$json = json_decode($result,true);

$session = $json['session'];

echo "session: $session \n";

$result = file_get_contents("http://54.213.19.254/pushdice/inapp_purchase/key/com.digitalmochi.pushdices.coin1/session/$session");

echo "result: $result \n";
?>
