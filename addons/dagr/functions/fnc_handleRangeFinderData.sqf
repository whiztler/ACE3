/*
 * Author: Rosuto, Ruthberg
 * Handles incoming data packets from the Vectronix Vector LRF
 *
 * Arguments:
 * 0: Slope distance (Meters) <NUMBER>
 * 1: Azimuth (Degrees) <NUMBER>
 * 2: Inclination (Degrees) <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [1000, 45, 1] call ace_dagr_fnc_handleRangeFinderData
 *
 * Public: No
 */
#include "script_component.hpp"

#define EMP_RF_ACC 5 // Rangefinder Accuracy

PARAMS_3(_slopeDistance,_azimuth,_inclination);

if (GVAR(vectorConnected)) then {
    GVAR(LAZPOS) = (eyePos player) vectorAdd ([_slopeDistance, _azimuth, _inclination] call CBA_fnc_polar2vect);
    GVAR(LAZDIST) = _slopeDistance * cos(_inclination);
    GVAR(LAZDIST) = floor (GVAR(LAZDIST) / EMP_RF_ACC) *  EMP_RF_ACC;
    GVAR(LAZHEADING) = _azimuth;
    GVAR(noVectorData) = false;
};
