---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_shield_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_shield_silver.init()

    return {
        description = "Silver shield",
        depends = "metal_silver",
    }

end

function unilib.pkg.armour_shield_silver.exec()

    unilib.register_armour("unilib:armour_shield_silver", "technic_armor:shield_silver", mode, {
        -- From technic_armor:shield_silver
        description = S("Silver Shield"),
        inventory_image = "unilib_armour_shield_silver_inv.png",
        groups = {armour_heal = 6, armour_radiation = 0, armour_shield = 9, armour_use = 650},
    })
    unilib.register_craft_shield({
        -- From technic_armor:shield_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })

end
