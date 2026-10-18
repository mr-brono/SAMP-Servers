#define MAX_FACTIONS 5
new PlayerFaction[1000], PlayerRank[1000];
CMD:makefaction(playerid, params[]) { new id,f,r; if(sscanf(params,"udd",id,f,r)) return SendClientMessage(playerid,-1,"/makefaction [id] [1-5] [rank] 1=Police 2=Army 3=Govt 4=Medic 5=Fire"); PlayerFaction[id]=f; PlayerRank[id]=r; SendClientMessage(id,-1,"تم تعيينك في فصيل!"); return 1; }
CMD:myfaction(playerid) { new str[128]; format(str,128,"فصيلك: %d رتبتك: %d",PlayerFaction[playerid],PlayerRank[playerid]); SendClientMessage(playerid,-1,str); return 1; }
CMD:fmenu(playerid) { if(PlayerFaction[playerid]==0) return SendClientMessage(playerid,-1,"لست في فصيل"); ShowPlayerDialog(playerid,1,DIALOG_STYLE_LIST,"قائمة الفصيل","سيارات الفصيل\nمقر الفصيل\nالأعضاء","اختيار","اغلاق"); return 1; }
