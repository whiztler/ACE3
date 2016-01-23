/*
 * Author: PabstMirror (based on repack from commy2, esteldunedain, Ruthberg)
 * Starts repacking a specific magazine classname.
 * If room in inventory, unload magazine from weapon to be repacked.
 * Precalcs all the event timings and starts the progressBar.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Magazine Classname <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * ["30Rnd_65x39_caseless_mag"] call ace_magazinerepack_fnc_startRepackingMagazine
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_magazineCfg", "_fullMagazineCount", "_isBelt", "_startingAmmoCounts", "_simEvents", "_totalTime"];

params ["_target", "_player", "_magazineClassname"];

if (isNil "_magazineClassname" || {_magazineClassname == ""}) exitWith {ERROR("Bad Mag Classname");};
_magazineCfg = configFile >> "CfgMagazines" >> _magazineClassname;
// Calculate actual ammo to transfer during repack
_fullMagazineCount = getNumber (_magazineCfg >> "count");
//Is linked belt magazine:
_isBelt = (isNumber (_magazineCfg >> "ACE_isBelt")) && {(getNumber (_magazineCfg >> "ACE_isBelt")) == 1};

//Check canInteractWith:
if (!([_player, objNull, ["isNotInside", "isNotSitting"]] call EFUNC(common,canInteractWith))) exitWith {};

[_player] call EFUNC(common,goKneeling);

_startingAmmoCounts = [];
{
    EXPLODE_4_PVT(_x,_xClassname,_xCount,_xLoaded,_xType);
    if ((_xClassname == _magazineClassname) && {(_xCount != _fullMagazineCount) && {_xCount > 0}}) then {
        if (_xLoaded) then {
            //Try to Remove from weapon and add to inventory, otherwise ignore
            if (_player canAdd _magazineClassname) then {
                switch (_xType) do {
                case (1): {_player removePrimaryWeaponItem _magazineClassname;};
                case (2): {_player removeHandgunItem _magazineClassname;};
                case (4): {_player removeSecondaryWeaponItem _magazineClassname;};
                    default {ERROR("Loaded Location Invalid");};
                };
                _player addMagazine [_magazineClassname, _xCount];
                _startingAmmoCounts pushBack _xCount;
            };
        } else {
            _startingAmmoCounts pushBack _xCount;
        };
    };
} forEach (magazinesAmmoFull _player);

if ((count _startingAmmoCounts) < 2) exitWith {ERROR("Not Enough Mags to Repack");};

_simEvents = [_fullMagazineCount, _startingAmmoCounts, _isBelt] call FUNC(simulateRepackEvents);
_totalTime = (_simEvents select ((count _simEvents) - 1) select 0);

[
    _totalTime,
    [_magazineClassname, _startingAmmoCounts, _simEvents],
    {_this call FUNC(magazineRepackFinish)},
    {_this call FUNC(magazineRepackFinish)},
    (localize LSTRING(RepackingMagazine)),
    {_this call FUNC(magazineRepackProgress)},
    ["isNotInside", "isNotSitting"]
] call EFUNC(common,progressBar);
