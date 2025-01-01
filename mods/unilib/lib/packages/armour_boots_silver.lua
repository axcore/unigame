---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_silver.init()

    return {
        description = "Silver boots",
        depends = "metal_silver",
    }

end

function unilib.pkg.armour_boots_silver.exec()

    unilib.register_armour("unilib:armour_boots_silver", "technic_armor:boots_silver", mode, {
        -- From technic_armor:boots_silver
        description = S("Silver Boots"),
        inventory_image = "unilib_armour_boots_silver_inv.png",
        groups = {armour_feet = 7, armour_heal = 6, armour_radiation = 5, armour_use = 650},
    })
    unilib.register_craft_boots({
        -- From technic_armor:boots_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })

end
