/*
 * Author: commy2
 * Waits for the flashbang grenade fuze to trigger and 'explode'
 *
 * Arguments:
 * 0: projectile - Flashbang Grenade <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [theFlashbang] call ace_grenades_fnc_flashbangThrownFuze
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_projectile"];

if (alive _projectile) then {
    playSound3D ["A3\Sounds_F\weapons\Explosion\explosion_mine_1.wss", _projectile, false, getPosASL _projectile, 5, 1.2, 400];

    private _affected = _projectile nearEntities ["CAManBase", 50];

    ["flashbangExplosion", _affected, [_projectile]] call EFUNC(common,targetEvent);
};
