/*
	Name: cTab_fnc_onIfclose
	
	Author(s):
		Gundy
	
	Description:
		Closes the currently open interface and remove any previously registered eventhandlers.
	
	Parameters:
		No Parameters
	
	Returns:
		BOOLEAN - TRUE
	
	Example:
		[] call cTab_fnc_onIfclose;
*/

private ["_displayName","_mapScale","_ifType","_player","_playerKilledEhId","_vehicle","_vehicleGetOutEhId","_draw3dEhId","_aceUnconciousEhId","_acePlayerInventoryChangedEhId"];

// remove helmet and UAV cameras
[] call cTab_fnc_deleteHelmetCam;
[] call cTab_fnc_deleteUAVcam;

if !(isNil "cTabIfOpen") then {
	// [_ifType,_displayName,_player,_playerKilledEhId,_vehicle,_vehicleGetOutEhId]
	_ifType = cTabIfOpen select 0;
	_displayName = cTabIfOpen select 1;
	_player = cTabIfOpen select 2;
	_playerKilledEhId = cTabIfOpen select 3;
	_vehicle = cTabIfOpen select 4;
	_vehicleGetOutEhId = cTabIfOpen select 5;
	_draw3dEhId = cTabIfOpen select 6;
	_aceUnconciousEhId = cTabIfOpen select 7;
	_acePlayerInventoryChangedEhId = cTabIfOpen select 8;
	
	uiNamespace setVariable [_displayName, displayNull];
	
	if (!isNil "_playerKilledEhId") then {_player removeEventHandler ["killed",_playerKilledEhId]};
	if (!isNil "_vehicleGetOutEhId") then {_vehicle removeEventHandler ["GetOut",_vehicleGetOutEhId]};
	if (!isNil "_draw3dEhId") then {removeMissionEventHandler ["Draw3D",_draw3dEhId]};
	if (!isNil "_aceUnconciousEhId") then {["medical_onUnconscious",_aceUnconciousEhId] call ace_common_fnc_removeEventHandler};
	if (!isNil "_acePlayerInventoryChangedEhId") then {["playerInventoryChanged",_acePlayerInventoryChangedEhId] call ace_common_fnc_removeEventHandler};
	
	// don't call this part if we are closing down before setup has finished
	if (!cTabIfOpenStart) then {
		// Save mapWorldPos and mapScaleDlg of current dialog so it can be restored later
		if ([_displayName] call cTab_fnc_isDialog) then {
			_mapScale = cTabMapScale * cTabMapScaleFactor / 0.86 * (safezoneH * 0.8);
			[_displayName,[["mapWorldPos",cTabMapWorldPos],["mapScaleDlg",_mapScale]],false] call cTab_fnc_setSettings;
		};
	};
	
	cTabIfOpen = nil;
};

cTabCursorOnMap = false;
cTabIfOpenStart = false;

true