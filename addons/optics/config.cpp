#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {
            "ACE_optic_Hamr_2D",
            "ACE_optic_Hamr_PIP",
            "ACE_optic_Arco_2D",
            "ACE_optic_Arco_PIP",
            "ACE_optic_MRCO_2D",
            //"ACE_optic_MRCO_PIP",
            "ACE_optic_SOS_2D",
            "ACE_optic_SOS_PIP",
            "ACE_optic_LRPS_2D",
            "ACE_optic_LRPS_PIP"
            //"ACE_optic_DMS"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author[] = {"Taosenai","KoffeinFlummi","commy2"};
        authorUrl = "http://www.ryanschultz.org/tmr/";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

#include "CfgOpticsEffect.hpp"
#include "CfgRscTitles.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "CfgJointRails.hpp"

#include "CfgPreloadTextures.hpp"
