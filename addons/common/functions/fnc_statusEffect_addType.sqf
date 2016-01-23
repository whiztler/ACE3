/*
 * Author: PabstMirror
 * Adds a status effect that will be handled.
 *
 * Arguments:
 * 0: Status Effect Name, this should match a corisponding event name <STRING>
 * 1: Send event globaly <BOOL>
 * 2: Common Effect Reaons to pre-seed durring init <ARRAY>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * ["setCaptive", true, []] call ace_common_fnc_statusEffect_addType
 *
 * Public: No
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_name", "", [""]], ["_isGlobal", false, [false]], ["_commonReasonsArray", [], [[]]]];
TRACE_3("params",_name,_isGlobal,_commonReasonsArray);

if (_name == "") exitWith {ACE_LOGERROR_1("addStatusEffect - Bad Name %1", _this)};
if (_name in GVAR(statusEffect_Names)) exitWith {ACE_LOGWARNING_1("addStatusEffect - Effect Already Added (note, will not update global bit) %1", _this)};

GVAR(statusEffect_Names) pushBack _name;
GVAR(statusEffect_isGlobal) pushBack _isGlobal;

//We add reasons at any time, but more efficenet to add all common ones at one time during init
if (isServer && {!(_commonReasonsArray isEqualTo [])}) then {
    //Switch case to lower:
    {
        _commonReasonsArray set [_forEachIndex, toLower _x];
    } forEach _commonReasonsArray;
    missionNamespace setVariable [(format [QGVAR(statusEffects_%1), _name]), _commonReasonsArray, true];
};
