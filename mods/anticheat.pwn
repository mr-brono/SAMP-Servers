public OnPlayerUpdate(playerid) { if(GetPlayerMoney(playerid) > 99999999) { Ban(playerid); } return 1; }
public OnPlayerWeaponCheat(playerid) { SendClientMessage(playerid,-1,"تم كشف هاك!"); Ban(playerid); return 1; }
