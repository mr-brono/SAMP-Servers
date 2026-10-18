new AdminLevel[1000];
CMD:makeadmin(playerid, params[]) { if(!IsPlayerAdmin(playerid)) return 0; new id,lvl; if(sscanf(params,"ud",id,lvl)) return SendClientMessage(playerid,-1,"/makeadmin [id] [1-5]"); AdminLevel[id]=lvl; SendClientMessage(id,-1,"صرت ادمن!"); return 1; }
CMD:ban(playerid, params[]) { if(AdminLevel[playerid]<2) return 0; new id,reason[64]; if(sscanf(params,"us[64]",id,reason)) return SendClientMessage(playerid,-1,"/ban [id] [reason]"); Ban(id); return 1; }
CMD:kick(playerid, params[]) { if(AdminLevel[playerid]<1) return 0; new id; if(sscanf(params,"u",id)) return 0; Kick(id); return 1; }
