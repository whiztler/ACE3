/*
 * Author: PabstMirror
 * Called when the mortar is fired.
 *
 * Arguments:
 * 0: mortar - Object the event handler is assigned to <OBJECT>
 * 1: weapon - Fired weapon <STRING>
 * 2: muzzle - Muzzle that was used <STRING>
 * 3: mode - Current mode of the fired weapon <STRING>
 * 4: ammo - Ammo used <STRING>
 * 5: magazine - magazine name which was used <STRING>
 * 6: projectile - Object of the projectile that was shot <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [clientFiredBIS-XEH] call ace_mk6mortar_fnc_handleFired
 *
 * Public: No
 */
#include "script_component.hpp"

if (!GVAR(airResistanceEnabled)) exitWith {};

PARAMS_7(_vehicle,_weapon,_muzzle,_mode,_ammo,_magazine,_projectile);

private ["_shooterMan", "_temperature", "_newMuzzleVelocityCoefficent", "_bulletVelocity", "_bulletSpeed"];

// Large enough distance to not simulate any wind deflection
if (_vehicle distance ACE_player > 8000) exitWith {false};

//AI will have no clue how to use:
_shooterMan = gunner _vehicle;
if (!([_shooterMan] call EFUNC(common,isPlayer))) exitWith {false};

//Calculate air density:
_altitude = (getPosASL _vehicle) select 2;
_temperature = _altitude call EFUNC(weather,calculateTemperatureAtHeight);
_pressure = _altitude call EFUNC(weather,calculateBarometricPressure);
_relativeHumidity = EGVAR(weather,currentHumidity);
_airDensity = [_temperature, _pressure, _relativeHumidity] call EFUNC(weather,calculateAirDensity);
_relativeDensity = _airDensity / 1.225;

TRACE_5("FiredWeather",_temperature,_pressure,_relativeHumidity,_airDensity,_relativeDensity);

//powder effects:
_newMuzzleVelocityCoefficent = (((_temperature + 273.13) / 288.13 - 1) / 40 + 1);
if (_newMuzzleVelocityCoefficent != 1) then {
    _bulletVelocity = velocity _projectile;
    _bulletSpeed = vectorMagnitude _bulletVelocity;
    _bulletVelocity = (vectorNormalized _bulletVelocity) vectorMultiply (_bulletSpeed * _newMuzzleVelocityCoefficent);
    _projectile setVelocity _bulletVelocity;
};


[{
    private ["_deltaT", "_bulletVelocity", "_bulletSpeed", "_trueVelocity", "_trueSpeed", "_dragRef", "_accelRef", "_drag", "_accel"];
    PARAMS_2(_args,_pfID);
    EXPLODE_4_PVT(_args,_shell,_airFriction,_time,_relativeDensity);

    if (isNull _shell || {!alive _shell}) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };

    _deltaT = ACE_time - _time;
    _args set[2, ACE_time];

    _bulletVelocity = velocity _shell;
    _bulletSpeed = vectorMagnitude _bulletVelocity;

    _trueVelocity = _bulletVelocity vectorDiff ACE_wind;
    _trueSpeed = vectorMagnitude _trueVelocity;

    _drag = _deltaT * _airFriction * _trueSpeed * _relativeDensity;
    _accel = _trueVelocity vectorMultiply (_drag);
    _bulletVelocity = _bulletVelocity vectorAdd _accel;

    _shell setVelocity _bulletVelocity;

}, 0, [_projectile, MK6_82mm_AIR_FRICTION, ACE_time, _relativeDensity]] call CBA_fnc_addPerFrameHandler;
