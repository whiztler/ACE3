/*
 * Author: commy2
 * Remove backpacks and grenades from Magazines filter.
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

!(_this call FUNC(filterBackpacks)) && {!(_this call FUNC(filterGrenades))}
