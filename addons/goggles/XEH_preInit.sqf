#include "script_component.hpp"

ADDON = false;

// effects
PREP(applyDirtEffect);
PREP(applyDustEffect);
PREP(applyGlassesEffect);
PREP(applyRainEffect);
PREP(applyRotorWashEffect);
PREP(removeDirtEffect);
PREP(removeDustEffect);
PREP(removeGlassesEffect);
PREP(removeRainEffect);

// public
PREP(externalCamera);
PREP(isDivingGoggles);
PREP(isGogglesVisible);
PREP(isInRotorWash);

// general
PREP(clearGlasses);
PREP(getExplosionIndex);

// eventhandlers
PREP(handleExplosion);
PREP(handleFired);
PREP(handleKilled);

ADDON = true;
