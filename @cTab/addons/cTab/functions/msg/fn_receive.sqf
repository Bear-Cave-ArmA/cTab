_msgRecipient = _this select 0;
_msgTitle = _this select 1;
_msgBody = _this select 2;
_msgEncryptionKey = _this select 3;
_sender = _this select 4;
_playerEncryptionKey = call cTab_fnc_getPlayerEncryptionKey;
_msgArray = _msgRecipient getVariable [format ["cTab_messages_%1",_msgEncryptionKey],[]];
_msgArray pushBack [_msgTitle,_msgBody,0];

_msgRecipient setVariable [format ["cTab_messages_%1",_msgEncryptionKey],_msgArray];

if (_msgRecipient == cTab_player && _sender != cTab_player && {_playerEncryptionKey == _msgEncryptionKey} && {[cTab_player,["ItemcTab","ItemAndroid"]] call cTab_fnc_checkGear}) then {
	playSound "cTab_phoneVibrate";

	if (!isNil "cTabIfOpen" && {[cTabIfOpen select 1,"mode"] call cTab_fnc_getSettings == "MESSAGE"}) then {
		_nop = [] call cTab_msg_fnc_gui_load;

		// add a notification
		["MSG",format ["New message from %1",name _sender],6] call cTab_fnc_addNotification;
	} else {
		cTabRscLayerMailNotification cutRsc ["cTab_Mail_ico_disp", "PLAIN"]; //show
	};
};