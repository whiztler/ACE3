#include "script_component.hpp"

ADDON = false;

PREP(onMenuOpen);
PREP(onMenuClose);
PREP(openMenu);

PREP(canOpenMenu);
PREP(updateIcons);
PREP(updateUIInfo);
PREP(handleUI_DisplayOptions);
PREP(handleUI_dropDownTriageCard);
PREP(getTreatmentOptions);
PREP(updateActivityLog);
PREP(updateQuickViewLog);
PREP(updateBodyImage);
PREP(updateInformationLists);
PREP(setTriageStatus);
PREP(collectActions);
PREP(module);

GVAR(INTERACTION_TARGET) = objNull;
GVAR(actionsOther) = [];
GVAR(actionsSelf) = [];
GVAR(selectedBodyPart) = 0;

call FUNC(collectActions);

ADDON = true;
