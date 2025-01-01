---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_silver.init()

    return {
        description = "Silver helmet",
        depends = "metal_silver",
    }

end

function unilib.pkg.armour_helmet_silver.exec()

    unilib.register_armour("unilib:armour_helmet_silver", "technic_armor:helmet_silver", mode, {
        -- From technic_armor:helmet_silver
        description = S("Silver Helmet"),
        inventory_image = "unilib_armour_helmet_silver_inv.png",
        groups = {armour_head = 9, armour_heal = 6, armour_radiation = 5, armour_use = 650},
    })
    unilib.register_craft_helmet({
        -- From technic_armor:helmet_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })

end
