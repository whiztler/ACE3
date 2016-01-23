/*
 * Author: commy2
 * Converts some keys to an Arma Dik Code.
 *
 * Arguments:
 * 0: Key <STRING>
 *
 * Return Value:
 * Dik Code <NUMBER>
 *
 * Public: Yes
 *
 * Deprecated
 */
#include "script_component.hpp"

ACE_DEPRECATED("ace_common_fnc_codeToLetter","3.5.0","-");

["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] select ([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38, 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 44, 21] find (_this select 0)) + 1
