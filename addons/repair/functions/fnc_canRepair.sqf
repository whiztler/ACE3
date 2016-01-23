/*
 * Author: Glowbal
 * Check if the repair action can be performed.
 *
 * Arguments:
 * 0: Unit that does the repairing <OBJECT>
 * 1: Vehicle to repair <OBJECT>
 * 2: Selected hitpoint or hitpointIndex <STRING>or<NUMBER>
 * 3: Repair Action Classname <STRING>
 *
 * Return Value:
 * Can Repair <BOOL>
 *
 * Example:
 * [player, car, "HitHull", "MiscRepair"] call ace_repair_fnc_canRepair
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_caller", "_target", "_hitPoint", "_className"];
TRACE_4("params",_caller,_target,_hitPoint,_className);

private ["_config", "_engineerRequired", "_items", "_return", "_condition", "_vehicleStateCondition", "_settingName", "_settingItemsArray"];

_config = (ConfigFile >> "ACE_Repair" >> "Actions" >> _className);
if !(isClass _config) exitWith {false}; // or go for a default?
if(isEngineOn _target) exitWith {false};

_engineerRequired = if (isNumber (_config >> "requiredEngineer")) then {
    getNumber (_config >> "requiredEngineer");
} else {
    // Check for required class
    if (isText (_config >> "requiredEngineer")) exitWith {
        missionNamespace getVariable [(getText (_config >> "requiredEngineer")), 0];
    };
    0;
};
if !([_caller, _engineerRequired] call FUNC(isEngineer)) exitWith {false};

//Items can be an array of required items or a string to a ACE_Setting array
_items = if (isArray (_config >> "items")) then {
    getArray (_config >> "items");
} else {
    _settingName = getText (_config >> "items");
    _settingItemsArray = getArray (configFile >> "ACE_Settings" >> _settingName >> "_values");
    if ((isNil _settingName) || {(missionNamespace getVariable _settingName) >= (count _settingItemsArray)}) exitWith {
        ERROR("bad setting"); ["BAD"]
    };
    _settingItemsArray select (missionNamespace getVariable _settingName);
};
if (count _items > 0 && {!([_caller, _items] call FUNC(hasItems))}) exitWith {false};

_return = true;
if (getText (_config >> "condition") != "") then {
    _condition = getText (_config >> "condition");
    if (isNil _condition) then {
        _condition = compile _condition;
    } else {
        _condition = missionNamespace getVariable _condition;
    };
    if (_condition isEqualType false) then {
        _return = _condition;
    } else {
        _return = [_caller, _target, _hitPoint, _className] call _condition;
    };
};

if (!_return) exitWith {false};

// _vehicleStateCondition = if (isText(_config >> "vehicleStateCondition")) then {
    // missionNamespace getVariable [getText(_config >> "vehicleStateCondition"), 0]
// } else {
    // getNumber(_config >> "vehicleStateCondition")
// };
// if (_vehicleStateCondition == 1 && {!([_target] call FUNC(isInStableCondition))}) exitWith {false};

private _repairLocations = getArray (_config >> "repairLocations");
if (!("All" in _repairLocations)) then {
    private _repairFacility = {([_caller] call FUNC(isInRepairFacility)) || ([_target] call FUNC(isInRepairFacility))};
    private _repairVeh = {([_caller] call FUNC(isNearRepairVehicle)) || ([_target] call FUNC(isNearRepairVehicle))};
    {
        if (_x == "field") exitWith {_return = true;};
        if (_x == "RepairFacility" && _repairFacility) exitWith {_return = true;};
        if (_x == "RepairVehicle" && _repairVeh) exitWith {_return = true;};
        if !(isNil _x) exitWith {
            private _val = missionNamespace getVariable _x;
            if (_val isEqualType 0) then {
                _return = switch (_val) do {
                    case 0: {true}; //useAnywhere
                    case 1: {call _repairVeh}; //repairVehicleOnly
                    case 2: {call _repairFacility}; //repairFacilityOnly
                    case 3: {(call _repairFacility) || {call _repairVeh}}; //vehicleAndFacility
                    default {false}; //Disabled
                };
            };
        };
    } forEach _repairLocations;
};
if (!_return) exitWith {false};

//Check that there are required objects nearby
private _requiredObjects = getArray (_config >> "claimObjects");
if (!(_requiredObjects isEqualTo [])) then {
    private _objectsAvailable = [_caller, 5, _requiredObjects] call FUNC(getClaimObjects);
    if (_objectsAvailable isEqualTo []) then {
            TRACE_2("Missing Required Objects",_requiredObjects,_objectsAvailable);
        _return = false
    };
};

_return && {alive _target};
