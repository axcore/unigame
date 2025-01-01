---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_steel_stainless = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_steel_stainless.init()

    return {
        description = "Stainless steel shield",
        depends = "metal_steel_stainless",
    }

end

function unilib.pkg.armour_shield_steel_stainless.exec()

    unilib.register_armour(
        -- From technic_armor:shield_stainless
        "unilib:armour_shield_steel_stainless",
        "technic_armor:shield_stainless",
        mode,
        {
            description = S("Stainless Steel Shield"),
            inventory_image = "unilib_armour_shield_steel_stainless_inv.png",
            groups = {armour_heal = 10, armour_radiation = 0, armour_shield = 13, armour_use = 75},
        }
    )
    unilib.register_craft_shield({
        -- From technic_armor:shield_stainless
        part_name = "steel_stainless",
        ingredient = "unilib:metal_steel_stainless_ingot",
    })

end
