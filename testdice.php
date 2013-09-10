<?php

$accesstoken = "CAACEdEose0cBAA56DeSA9QgX06g6sZBqZB0fPi4drcocxZBJMlJp3ynOmtXx5y2qNjZC98qMFmLgTZCA4PwyZBDZBtMWMqBok6wKZCUPTyQSmzP6KZCKrIAGWatqMghPDlN2rB1DAQTZCAhE4oTHYePOXtsZCvlbNdPjw2viIQrTRPdMHOpFEqSHziHtnX1EL3tPjQZD";
$result = file_get_contents("http://54.213.19.254/pushdice/friends/accesstoken/$accesstoken");
echo "p1 create game: $result \n";
echo "\n";
