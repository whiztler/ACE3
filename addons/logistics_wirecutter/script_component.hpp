#define COMPONENT logistics_wirecutter
#include "\z\ace\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL

#ifdef DEBUG_ENABLED_LOGISTICS_WIRECUTTER
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_LOGISTICS_WIRECUTTER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOGISTICS_WIRECUTTER
#endif

#include "\z\ace\addons\main\script_macros.hpp"


//find is case sensitive, so keep everything lowercase
#define FENCE_P3DS ["mil_wiredfence_f.p3d","wall_indfnc_3.p3d", "wall_indfnc_9.p3d", "wall_indfnc_corner.p3d", "pletivo_wired.p3d", "wall_fen1_5.p3d"]

#define SOUND_CLIP_TIME_SPACEING    1.5
