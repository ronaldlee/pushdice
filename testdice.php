<?php

$accesstoken = "CAACEdEose0cBAAphZBPSWLJ6fRZCjFmurQZBAitkDaMNzDp9wEzF5YBS7aWZA7ZAuYbMd9EWbSheFaLrcG7Age2IXb9zHzIzmAPQiKK4rXoMnmIZBeDH91sTjMFEjYZAa3NYxxT8BUTM85R8b8uR8ZCfvLHsGY8g2PZBCiQEmrmarT4ZCeklk4V6J9bEbzUET48XAZD";
$result = file_get_contents("http://54.213.19.254/pushdice/friends/accesstoken/$accesstoken");
echo "p1 create game: $result \n";
echo "\n";
