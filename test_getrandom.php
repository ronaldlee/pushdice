<?php

$uid = 61;

$result = file_get_contents("http://54.213.19.254/gameroom/getRandomPlayers/uid/$uid");

echo "result: $result \n";
?>
