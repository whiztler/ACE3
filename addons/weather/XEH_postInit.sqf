#include "script_component.hpp"

// Randomization
GVAR(temperatureShift) = 3 - random 6;
GVAR(badWeatherShift) = (random 1) ^ 2 * 10;
GVAR(humidityShift) = (5 - random 10) / 100;

GVAR(wind_period_start_time) = ACE_time;
GVAR(rain_period_start_time) = ACE_time;

GVAR(ACE_rain) = rain;

"ACE_WIND_PARAMS" addPublicVariableEventHandler { GVAR(wind_period_start_time) = ACE_time; };
"ACE_RAIN_PARAMS" addPublicVariableEventHandler { GVAR(rain_period_start_time) = ACE_time; };
"ACE_MISC_PARAMS" addPublicVariableEventHandler {
    if (!isServer) then {
        TRACE_1("MISC PARAMS PVEH",ACE_MISC_PARAMS);
        if (GVAR(syncMisc)) then {
            30 setLightnings (ACE_MISC_PARAMS select 0);
            30 setRainbow    (ACE_MISC_PARAMS select 1);
            30 setFog        (ACE_MISC_PARAMS select 2);
        };
        GVAR(temperatureShift) = (ACE_MISC_PARAMS select 3);
        GVAR(badWeatherShift)  = (ACE_MISC_PARAMS select 4);
        GVAR(humidityShift)    = (ACE_MISC_PARAMS select 5);
        call FUNC(updateTemperature);
        call FUNC(updateHumidity);
    };
};

GVAR(WindInfo) = false;
["ACE3 Common", QGVAR(WindInfoKey), localize LSTRING(WindInfoKey),
{
    // Conditions: canInteract
    if !([ACE_player, ACE_player, []] call EFUNC(common,canInteractWith)) exitWith {false};

    // Statement
    [] call FUNC(displayWindInfo);
},
{false},
[37, [true, false, false]], false, 0] call CBA_fnc_addKeybind; // (SHIFT + K)

simulWeatherSync;




["SettingsInitialized",{
    TRACE_1("SettingsInitialized",GVAR(syncRain));

    //Create a 0 sec delay PFEH to update rain every frame:
    if (GVAR(syncRain)) then {
        [{
            0 setRain GVAR(ACE_rain);
        }, 0, []] call CBA_fnc_addPerFrameHandler;
    };

    //Create a 1 sec delay PFEH to update wind/rain/temp/humidity:

    //If we don't sync rain, set next time to infinity
    GVAR(nextUpdateRain) = if (GVAR(syncRain)) then {0} else {1e99};
    GVAR(nextUpdateTempAndHumidity) = 0;
    [{
        BEGIN_COUNTER(weatherPFEH);

        [] call FUNC(updateWind); //Every 1 second

        if (ACE_time >= GVAR(nextUpdateRain)) then {
            [] call FUNC(updateRain); //Every 2 seconds
            GVAR(nextUpdateRain) = 2 + ACE_time;
        };
        if (ACE_time >= GVAR(nextUpdateTempAndHumidity)) then {
            [] call FUNC(updateTemperature); //Every 20 seconds
            [] call FUNC(updateHumidity); //Every 20 seconds
            GVAR(nextUpdateTempAndHumidity) = 20 + ACE_time;
        };

        END_COUNTER(weatherPFEH);
    }, 1, []] call CBA_fnc_addPerFrameHandler;

}] call EFUNC(common,addEventHandler);
