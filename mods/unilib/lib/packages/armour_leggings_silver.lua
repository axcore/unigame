---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_silver.init()

    return {
        description = "Silver leggings",
        depends = "metal_silver",
    }

end

function unilib.pkg.armour_leggings_silver.exec()

    unilib.register_armour("unilib:armour_leggings_silver", "technic_armor:leggings_silver", mode, {
        -- From technic_armor:leggings_silver
        description = S("Silver Leggings"),
        inventory_image = "unilib_armour_leggings_silver_inv.png",
        groups = {armour_heal = 6, armour_legs = 12, armour_radiation = 7, armour_use = 650},
    })
    unilib.register_craft_leggings({
        -- From technic_armor:leggings_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })

end
