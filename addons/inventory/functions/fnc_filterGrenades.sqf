/*
 * Author: commy2
 * Filter condition for the Grenades filter list
 *
 * Arguments:
 * 0: Item config entry <CONFIG>
 *
 * Return Value:
 * Item should appear in this list? <BOOL>
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_config"];

toLower configName _config in GVAR(Grenades_ItemList)
