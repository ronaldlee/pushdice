<?php

$uid= 61;
//$uid= 55;

$result = file_get_contents("http://54.213.19.254/gameroom/testcheckcoins/uid/$uid");

$json = json_decode($result,true);

?>
