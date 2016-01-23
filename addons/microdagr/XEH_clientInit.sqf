//XEH_clientInit.sqf
#include "script_component.hpp"

if (!hasInterface) exitWith {};

//Add deviceKey entry:
private ["_conditonCode", "_toggleCode", "_closeCode"];
_conditonCode = {
    ("ACE_microDAGR" in (items ACE_player))
};
_toggleCode = {
    if !([ACE_player, objNull, ["notOnMap", "isNotInside", "isNotSitting"]] call EFUNC(common,canInteractWith)) exitWith {};
    [] call FUNC(openDisplay); //toggle display mode
};
_closeCode = {
    if (GVAR(currentShowMode) == DISPLAY_MODE_CLOSED) exitWith {};
    [DISPLAY_MODE_CLOSED] call FUNC(openDisplay);
};
[(localize LSTRING(itemName)), QUOTE(PATHTOF(images\microDAGR_item.paa)), _conditonCode, _toggleCode, _closeCode] call EFUNC(common,deviceKeyRegisterNew);


//Add Eventhandler:
["RangerfinderData", {_this call FUNC(recieveRangefinderData)}] call EFUNC(common,addEventHandler);

//Global Variables to default:
GVAR(gpsPositionASL) = [0,0,0];
GVAR(mapAutoTrackPosition) = true;
GVAR(mapShowTexture) = false;
GVAR(mapPosition) = [-999, -999];
GVAR(mapZoom) = 0.075;
GVAR(currentApplicationPage) = APP_MODE_NULL;
GVAR(currentShowMode) = DISPLAY_MODE_CLOSED;

//User Settings
GVAR(settingUseMils) = false;
GVAR(settingShowAllWaypointsOnMap) = true;

GVAR(newWaypointPosition) = [];
GVAR(currentWaypoint) = -1;
GVAR(rangeFinderPositionASL) = [];

GVAR(mgrsGridZoneDesignator) = format ["%1 %2",EGVAR(common,MGRS_data) select 0, EGVAR(common,MGRS_data) select 1];
