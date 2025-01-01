---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_steel_carbon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_steel_carbon.init()

    return {
        description = "Carbon steel shield",
        depends = "metal_steel_carbon",
    }

end

function unilib.pkg.armour_shield_steel_carbon.exec()

    unilib.register_armour(
        -- From technic_armor:shield_carbon
        "unilib:armour_shield_steel_carbon",
        "technic_armor:shield_carbon",
        mode,
        {
            description = S("Carbon Steel Shield"),
            inventory_image = "unilib_armour_shield_steel_carbon_inv.png",
            groups = {armour_heal = 10, armour_radiation = 0, armour_shield = 13, armour_use = 100},
        }
    )
    unilib.register_craft_shield({
        -- From technic_armor:shield_carbon
        part_name = "steel_carbon",
        ingredient = "unilib:metal_steel_carbon_ingot",
    })

end
