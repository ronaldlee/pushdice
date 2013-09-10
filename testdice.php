<?php

$accesstoken = "CAACEdEose0cBAPqdyRFqPW8r7fbcKUY6n8P6WXZB8AEukZCphnsNXimLZC1FNUQIplcwtZCOiTryqOc9ovmL0cvw5NQAU934HGPJxhK7ZAPwVMYuOQNBQGJspDFpUHoWMDDVExXdoTDLtEJ3zZCRYvuZBZCjZCKhZA99yjOAUuN6VcrxIeQHcQFUFPmTNqIgKgOMUZD";
$result = file_get_contents("http://54.213.19.254/pushdice/friends/accesstoken/$accesstoken");
echo "p1 create game: $result \n";
echo "\n";
