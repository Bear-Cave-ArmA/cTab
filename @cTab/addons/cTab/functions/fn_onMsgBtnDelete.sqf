/*
Function called when DELETE button is pressed in messaging mode
Parameter 0: Name of uiNameSpace variable of display
Returns false if nothing was selected for deletion, else returns true
*/

_displayName = _this select 0;
_display = uiNamespace getVariable _displayName;
_msgLbCtrl = _display displayCtrl IDC_CTAB_MSG_LIST;
_msgLbSelection = lbSelection _msgLbCtrl;

if (count _msgLbSelection == 0) exitWith {false};
_playerEncryptionKey = call cTab_fnc_getPlayerEncryptionKey;
_msgArray = cTab_player getVariable [format ["cTab_messages_%1",_playerEncryptionKey],[]];

// run through the selection backwards as otherwise the indices won't match anymore
for "_i" from (count _msgLbSelection) to 0 step -1 do {
	_msgArray deleteAt (_msgLbSelection select _i);
};
cTab_player setVariable [format ["cTab_messages_%1",_playerEncryptionKey],_msgArray];

_msgTextCtrl = _display displayCtrl IDC_CTAB_MSG_CONTENT;
_msgTextCtrl ctrlSetText "No Message Selected";
_nop = [] call cTab_msg_fnc_gui_load;

true