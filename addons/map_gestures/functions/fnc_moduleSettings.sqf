/*
 * Author: Dslyecxi, MikeMatrix
 * Initializes Settings for the module and transcodes settings to a useable format.
 *
 * Arguments:
 * 0: Logic <LOGIC>
 * 1: Units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [module, [player], true] call ace_map_gestures_fnc_moduleGroupSettings
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic", "", "_activated"];

if (!_activated || !isServer) exitWith {};

[_logic, QGVAR(enabled), "enabled"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(maxRange), "maxRange"] call EFUNC(common,readSettingFromModule);
[_logic, QGVAR(interval), "interval"] call EFUNC(common,readSettingFromModule);

//For default fallback colors, setting to empty ("") will not force on clients
private _defaultLeadColor = _logic getVariable ["defaultLeadColor", ""];
if (_defaultLeadColor != "") then {
    _defaultLeadColor = call compile ("[" + _defaultLeadColor + "]");
    if (!([_defaultLeadColor] call FUNC(isValidColorArray))) exitWith {ERROR("defaultLeadColor is not a valid color array.")};
    [QGVAR(defaultLeadColor), _defaultLeadColor, true, true] call EFUNC(common,setSetting);
};

private _defaultColor = _logic getVariable ["defaultColor", ""];
if (_defaultColor != "") then {
    _defaultColor = call compile ("[" + _defaultColor + "]");
    if (!([_defaultColor] call FUNC(isValidColorArray))) exitWith {ERROR("defaultColor is not a valid color array.")};
    [QGVAR(defaultColor), _defaultColor, true, true] call EFUNC(common,setSetting);
};

ACE_LOGINFO("Map Gestures Module Initialized.");
