/*
	Name: cTab_fnc_deleteUAVcam
	
	Author(s):
		Gundy

	Description:
		Delete UAV camera
	
	Parameters:
		Optional:
		0: OBJECT - Camera to delete
 	
	Returns:
		BOOLEAN - TRUE
	
	Example:
		// delete all UAV cameras
		[] call cTab_fnc_deleteUAVcam;
		
		// delete a specific UAV camera
		[_cam] call cTab_fnc_deleteUAVcam;
*/

params [["_camToDelete",objNull]];

// remove cameras
for "_i" from (count cTabUAVcams -1) to 0 step -1 do {
	private _cam = cTabUAVcams select _i select 2;
	if (isNull _camToDelete || {_cam == _camToDelete}) then {
		0 = cTabUAVcams deleteAt _i;
		_cam cameraEffect ["TERMINATE","BACK"];
		camDestroy _cam;
	};
};

// remove camera direction update event handler if no more cams are present
if (count cTabUAVcams == 0) then {
	if (!isNil "cTabUavEventHandle") then {
		removeMissionEventHandler ["Draw3D",cTabUavEventHandle];
		cTabUavEventHandle = nil;
	};
};

true