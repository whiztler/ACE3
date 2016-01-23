
class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_FiredBIS_EventHandlers {
    class CAManBase {
        class ADDON {
            clientFiredBIS = QUOTE(if (local (_this select 0)) then {_this call FUNC(firedEHBB);};);
        };
    };

    class Tank {
        class ADDON {
            firedBIS = QUOTE(if (local (_this select 0)) then {_this call FUNC(firedEHOP);};);
        };
    };
    class Car {
        class ADDON {
            firedBIS = QUOTE(if (local (_this select 0)) then {_this call FUNC(firedEHOP);};);
        };
    };
    class Helicopter {
        class ADDON {
            firedBIS = QUOTE(if (local (_this select 0)) then {_this call FUNC(firedEHOP);};);
        };
    };
    class Plane {
        class ADDON {
            firedBIS = QUOTE(if (local (_this select 0)) then {_this call FUNC(firedEHOP);};);
        };
    };
    class Ship_F {
        class ADDON {
            firedBIS = QUOTE(if (local (_this select 0)) then {_this call FUNC(firedEHOP);};);
        };
    };
    class StaticWeapon {
        class ADDON {
            firedBIS = QUOTE(if (local (_this select 0)) then {_this call FUNC(firedEHOP);};);
        };
    };
};
