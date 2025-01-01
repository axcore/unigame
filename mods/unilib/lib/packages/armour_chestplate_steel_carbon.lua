---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_steel_carbon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_steel_carbon.init()

    return {
        description = "Carbon steel chestplate",
        depends = "metal_steel_carbon",
    }

end

function unilib.pkg.armour_chestplate_steel_carbon.exec()

    unilib.register_armour(
        -- From technic_armor:chestplate_carbon
        "unilib:armour_chestplate_steel_carbon",
        "technic_armor:chestplate_carbon",
        mode,
        {
            description = S("Carbon Steel Chestplate"),
            inventory_image = "unilib_armour_chestplate_steel_carbon_inv.png",
            groups = {armour_heal = 10, armour_radiation = 14, armour_torso = 21, armour_use = 100},
        }
    )
    unilib.register_craft_chestplate({
        -- From technic_armor:chestplate_carbon
        part_name = "steel_carbon",
        ingredient = "unilib:metal_steel_carbon_ingot",
    })

end
