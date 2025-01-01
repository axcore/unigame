---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic_armor
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_silver = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.technic_armor.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_silver.init()

    return {
        description = "Silver chestplate",
        depends = "metal_silver",
    }

end

function unilib.pkg.armour_chestplate_silver.exec()

    unilib.register_armour(
        -- From technic_armor:chestplate_silver
        "unilib:armour_chestplate_silver",
        "technic_armor:chestplate_silver",
        mode,
        {
            description = S("Silver Chestplate"),
            inventory_image = "unilib_armour_chestplate_silver_inv.png",
            groups = {armour_heal = 6, armour_radiation = 18, armour_torso = 14, armour_use = 650},
        }
    )
    unilib.register_craft_chestplate({
        -- From technic_armor:chestplate_silver
        part_name = "silver",
        ingredient = "unilib:metal_silver_ingot",
    })

end
