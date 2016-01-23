/*
 * Author: Jonpas
 * Sets Object View Distance dynamically based on current Field of View, between Object View Distance (minimal value) and View Distance (maximum value) set before this PFH starts.
 *
 * Arguments:
 * 0: PFH Arguments <ARRAY>
 * 1: PFH Handle <NUMBER>
 *
 * Return Value:
 * PFH Handle <NUMBER>
 *
 * Example:
 * [] call ace_viewdistance_fnc_setFovBasedOvdPFH
 *
 * Public: No
 */

#include "script_component.hpp"

#define VD_ZOOM_NORMAL 1.00041
#define VD_ZOOM_DIVISION 35
#define VD_ZOOM_DIVISION_AIR 10

params ["", "_idPFH"];

// Remove PFH and set Object View Distance back to what it was before
if (GVAR(objectViewDistanceCoeff) < 6) exitWith {
    [_idPFH] call CBA_fnc_removePerFrameHandler;
    GVAR(fovBasedPFHminimalViewDistance) = nil;
};

private ["_zoom"];
_zoom = (call CBA_fnc_getFov) select 1;

// Air
if ((vehicle ACE_player) isKindOf "Air") exitWith {
    if (_zoom > VD_ZOOM_NORMAL) then {
        // Dynamically set Object View Distance based on player's Zoom Level and View Distance
        setObjectViewDistance ((_zoom / VD_ZOOM_DIVISION_AIR * (viewDistance - GVAR(fovBasedPFHminimalViewDistance))) + GVAR(fovBasedPFHminimalViewDistance));
    } else {
        setObjectViewDistance (GVAR(fovBasedPFHminimalViewDistance) + viewDistance / 10);
    };
    TRACE_2("FoV Based",getObjectViewDistance select 0,_zoom);
};

// Land
if (_zoom > VD_ZOOM_NORMAL) then {
    // Dynamically set Object View Distance based on player's Zoom Level and View Distance
    setObjectViewDistance ((_zoom / VD_ZOOM_DIVISION * (viewDistance - GVAR(fovBasedPFHminimalViewDistance))) + GVAR(fovBasedPFHminimalViewDistance));
} else {
    setObjectViewDistance GVAR(fovBasedPFHminimalViewDistance);
};
TRACE_2("FoV Based",getObjectViewDistance select 0,_zoom);
