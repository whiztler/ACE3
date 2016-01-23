#include "script_component.hpp"

ADDON = false;

PREP(addObjectToCurator);
PREP(bi_moduleCurator);
PREP(bi_moduleMine);
PREP(bi_moduleProjectile);
PREP(bi_moduleRemoteControl);
PREP(handleZeusUnitAssigned);
PREP(moduleAddSpareTrack);
PREP(moduleAddSpareWheel);
PREP(moduleCaptive);
PREP(moduleSetMedic);
PREP(moduleSetMedicalVehicle);
PREP(moduleSetMedicalFacility);
PREP(moduleSurrender);
PREP(moduleUnconscious);
PREP(moduleZeusSettings);

if (isServer) then {
    ["zeusUnitAssigned", FUNC(handleZeusUnitAssigned)] call EFUNC(common,addEventHandler);
};

ADDON = true;
