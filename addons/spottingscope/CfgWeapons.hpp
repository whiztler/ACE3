
class CfgWeapons {
    class ACE_ItemCore;
    class InventoryItem_Base_F;
    
    class ACE_SpottingScope: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(DisplayName);
        descriptionShort = "";
        picture = PATHTOF(UI\w_spottingscope_ca.paa);
        model = PATHTOF(data\ace_spottingscope.p3d);
        
        class ItemInfo: InventoryItem_Base_F {
            mass = 40;
        };
    };
};
