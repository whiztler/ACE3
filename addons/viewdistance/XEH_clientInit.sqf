#include "script_component.hpp"

if (!hasInterface) exitWith {};

["SettingsInitialized", {
    // if not enabled, then bugger off.
    if !(GVAR(enabled)) exitWith {};

    // Limit on load
    [false] call FUNC(adaptViewDistance);

    // Set the EH which waits for any of the view distance settings to be changed, so that the effect is show immediately
    ["SettingChanged",{
        params ["_name"];
        if ((_name  == QGVAR(viewDistanceOnFoot)) ||
            (_name  == QGVAR(viewDistanceLandVehicle)) ||
            (_name  == QGVAR(viewDistanceAirVehicle)) ||
            (_name  == QGVAR(objectViewDistanceCoeff))) then {

            [true] call FUNC(adaptViewDistance);
        };
    }] call EFUNC(common,addEventHandler);

    // Set the EH which waits for a vehicle change to automatically swap between On Foot/In Land Vehicle/In Air Vehicle
    // Also run when SettingsInitialized runs (not guaranteed)
    ["playerVehicleChanged",{
        [false] call FUNC(adaptViewDistance)
    }] call EFUNC(common,addEventHandler);
}] call EFUNC(common,addEventHandler);
