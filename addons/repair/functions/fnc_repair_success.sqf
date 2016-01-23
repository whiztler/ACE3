/*
 * Author: KoffeinFlummi, Glowbal
 * Callback when repair completes.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Unit that does the repairing <OBJECT>
 *   1: Vehicle to repair <OBJECT
 *   2: Selected hitpoint or hitpointIndex <STRING>or<NUMBER>
 *   3: Repair Action Classname <STRING>
 *   4: Items <ARRAY>
 *   5: User of Items <ARRAY>
 *   6: Claimed Repair Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[unit, vehicle, "hitpoint", "classname", [], [], [aWheel]]] call ace_repair_fnc_repair_success
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_args"];
_args params ["_caller", "_target","_selectionName","_className","","","_claimedObjects"];
TRACE_4("params",_caller,_target,_selectionName,_className);

private ["_config","_callback", "_weaponSelect"];

if (primaryWeapon _caller == "ACE_FakePrimaryWeapon") then {
    _caller removeWeapon "ACE_FakePrimaryWeapon";
};
if (vehicle _caller == _caller) then {
    [_caller, _caller getVariable [QGVAR(repairPrevAnimCaller), ""], 2] call EFUNC(common,doAnimation);
};
_caller setVariable [QGVAR(repairPrevAnimCaller), nil];

_weaponSelect = (_caller getVariable [QGVAR(selectedWeaponOnrepair), ""]);
if (_weaponSelect != "") then {
    _caller selectWeapon _weaponSelect;
} else {
    _caller action ["SwitchWeapon", _caller, _caller, 99];
};

//Unclaim repair objects:
{
    TRACE_2("Releasing", _x, (typeOf _x));
    [objNull, _x, false] call EFUNC(common,claim);
} forEach _claimedObjects;

// Record specific callback
_config = (ConfigFile >> "ACE_Repair" >> "Actions" >> _className);

_callback = getText (_config >> "callbackSuccess");
if (isNil _callback) then {
    _callback = compile _callback;
} else {
    _callback = missionNamespace getVariable _callback;
};
_args call _callback;

//todo: repair litter?
