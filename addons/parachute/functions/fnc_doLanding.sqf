/*
 * Author: Garth 'L-H' de Wet
 * Performs the landing animation fix
 *
 * Arguments:
 * 0: unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ACE_Parachute_fnc_doLanding;
 *
 * Public: No
 */
#include "script_component.hpp"
private["_unit"];
_unit = _this select 0;
GVAR(PFH) = false;
[_unit, "AmovPercMevaSrasWrflDf_AmovPknlMstpSrasWrflDnon", 2] call EFUNC(common,doAnimation);
_unit setVariable [QGVAR(chuteIsCut), false, true];
[{
    if (ACE_time >= ((_this select 0) select 0) + 1) then {
        ((_this select 0) select 1) playActionNow "Crouch";
        [(_this select 1)] call CALLSTACK(CBA_fnc_removePerFrameHandler);
    };
}, 1, [ACE_time,_unit]] call CALLSTACK(CBA_fnc_addPerFrameHandler);
