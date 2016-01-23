/*
 * Author: Garth 'L-H' de Wet
 * Removes the glasses effect from the screen, removes dirt effect, removes rain effect, removes dust effect. Does not reset array (glasses will still be broken, dirty, ect.)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_goggles_fnc_removeGlassesEffect
 *
 * Public: Yes
 */
#include "script_component.hpp"

GVAR(EffectsActive) = false;
GVAR(PostProcess) ppEffectEnable false;

if (!isNull (GLASSDISPLAY)) then {
    GLASSDISPLAY closeDisplay 0;
};

call FUNC(removeDirtEffect);
call FUNC(removeRainEffect);
call FUNC(removeDustEffect);
