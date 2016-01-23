/*
 * Author: PabstMirror
 * Adds a key to a unit that will open a vehicle
 * Note: has global effects for Unit (will add items to remote unit)
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: custom key (true: custom key (magazine)  -  false: side key (item)) <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, car, true] call ACE_VehicleLock_fnc_addKeyForVehicle
 *
 * Public: Yes
 */
#include "script_component.hpp"

private ["_previousMags","_newMags","_keyMagazine","_keyName"];

if (!params [["_unit", objNull, [objNull]], ["_veh", objNull, [objNull]], ["_useCustom", false, [false]]]) exitWith {
    ERROR("Input wrong type");
};
TRACE_3("params",_unit,_veh,_useCustom);

if (isNull _unit) exitWith {ERROR("null unit");};
if (isNull _veh) exitWith {ERROR("null vehicle");};

if (_useCustom) then {
    _previousMags = magazinesDetail _unit;
    _unit addMagazine ["ACE_key_customKeyMagazine", 1]; //addMagazine array has global effects
    _newMags = (magazinesDetail _unit) - _previousMags;
    if ((count _newMags) == 0) exitWith {ERROR("failed to add magazine (inventory full?)");};
    _keyMagazine = _newMags select 0;
    TRACE_2("setting up key on server",_veh,_keyMagazine);
    //Have the server run add the key to the vehicle's key array:
    ["VehicleLock_SetupCustomKey", [_veh, _keyMagazine]] call EFUNC(common,serverEvent);
} else {
    _keyName = [_veh] call FUNC(getVehicleSideKey);
    _unit addItem _keyName; //addItem has global effects
};
