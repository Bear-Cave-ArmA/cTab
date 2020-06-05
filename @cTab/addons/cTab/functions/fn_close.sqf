/*
	Name: cTab_fnc_close

	Author(s):
		Gundy

	Description:
		Initiates the closing of currently open interface

	Parameters:
		No Parameters

	Returns:
		BOOLEAN - TRUE

	Example:
		[] call cTab_fnc_close;
*/

if !(isNil "cTabIfOpen") then {
	// [_ifType,_displayName,_player,_playerKilledEhId,_vehicle,_vehicleGetOutEhId]
	private _displayName = cTabIfOpen select 1;
	private _display = uiNamespace getVariable _displayName;

	_display closeDisplay 0;

	if !([_displayName] call cTab_fnc_isDialog) then {
		[] call cTab_fnc_onIfclose;
	};
};

true