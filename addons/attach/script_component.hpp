#define COMPONENT attach
#include "\z\ace\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_ATTACH
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ATTACH
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ATTACH
#endif

#include "\z\ace\addons\main\script_macros.hpp"

#define PLACE_WAITING -1
#define PLACE_CANCEL 0
#define PLACE_APPROVE 1
