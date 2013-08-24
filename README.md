readme

pushdice
  
http://.../pushdice/login/username/hsjs/id/5748484/type/fb/accesstoken/jsksks
http://.../pushdice/user/session/551376882539545111

init a game room for 2 players:
http://.../gameroom/init/p1_uid/11/p2_uid/22

p2 join the room create by p1:
http://.../gameroom/join/room_pid/%3C0.3680.0%3E/uid/22

p1 roll dice
http://.../gameroom/rolldice/room_pid/%3C0.3680.0%3E/p1_uid/11/buy_in/5

p 1 make a call: '9' means wildcard and be ignored.
http://.../gameroom/makecall/room_pid/%3C0.3680.0%3E/p1_uid/11/call/2/2/9/9/9/raise/2

p2 receive p1 call
http://.../gameroom/get_p1_call/room_pid/%3C0.3699.0%3E/p2_uid/22


At any time, any player can make this call to check the current room state to see if it is his turn.
http://.../gameroom/check/room_pid/%3C0.6945.0%3E
