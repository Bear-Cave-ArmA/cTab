/*
	Name: cTab_fnc_deleteHelmetCam
	
	Author(s):
		Gundy

	Description:
		Delete helmet camera
	
	Parameters:
		NONE
	
	Returns:
		BOOLEAN - TRUE
	
	Example:
		call cTab_fnc_deleteHelmetCam;

*/

if (!isNil "cTabHcams") then {
	params ["_cam"];

	_cam cameraEffect ["TERMINATE","BACK"];
	camDestroy _cam;
	deleteVehicle (cTabHcams select 1);
	cTabHcams = nil;
};

true