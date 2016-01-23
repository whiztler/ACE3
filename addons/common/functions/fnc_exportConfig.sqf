/*
 * Author: commy2
 * Export Config Entrys to RPT logs
 *
 * Arguments:
 * Config Path <CONFIG>
 *
 * Return Value:
 * None
 *
 * Example:
 * [configFile >> "CfgAmmo"] call ace_common_fnc_exportConfig;
 *
 * Public: No
 */
#include "script_component.hpp"

private _fnc_logEntries = {
    params ["_c", "_d"];

    private _p = inheritsFrom _c;

    private _t = format [["class %1: %2 {", "class %1 {"] select (configName _p == ""), configName _c, configName _p];
    for "_a" from 1 to _d do {
        _t = "  " + _t;
    };
    diag_log text _t;

    private _e = [];
    for "_i" from 0 to (count _c - 1) do {
        private _e1 = _c select _i;

        private _e2 = switch (true) do {
            case (isNumber _e1): {getNumber _e1};
            case (isText _e1): {getText _e1};
            case (isArray _e1): {getArray _e1};
            case (isClass _e1): {[_e1, _d + 1] call _fnc_logEntries; false};
        };

        if (!(_e2 isEqualType false)) then {
            if (_e2 isEqualType []) then {
                _e2 = toArray str _e2;
                {
                    if (_x == toArray "[" select 0) then {
                        _e2 set [_forEachIndex, toArray "{" select 0];
                    };
                    if (_x == toArray "]" select 0) then {
                        _e2 set [_forEachIndex, toArray "}" select 0];
                    };
                } forEach _e2;
                _e2 = toString _e2;
                _t = format ["%1[] = %2;", configName _e1, _e2];
            } else {
                _t = format ["%1 = %2;", configName _e1, str _e2];
            };
            for "_a" from 0 to _d do {
                _t = "  " + _t;
            };
            diag_log text _t;
        };
    };

    _t = "};";
    for "_a" from 1 to _d do {
        _t = "  " + _t;
    };
    diag_log text _t;
    diag_log text "";
};

[_this, 0] call _fnc_logEntries;
