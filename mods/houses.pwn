new HouseOwner[100][24];
CMD:buyhouse(playerid) { SendClientMessage(playerid,-1,"اشتريت البيت! اكتب /enter للدخول"); return 1; }
CMD:enter(playerid) { SetPlayerInterior(playerid,2); SetPlayerPos(playerid,269.2925,305.9277,999.1484); return 1; }
CMD:exit(playerid) { SetPlayerInterior(playerid,0); SetPlayerPos(playerid,1553.0,-1675.0,16.0); return 1; }
