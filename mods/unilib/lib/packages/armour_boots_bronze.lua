---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_bronze
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_bronze = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_bronze.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_bronze.init()

    return {
        description = "Bronze boots",
        depends = "metal_bronze",
    }

end

function unilib.pkg.armour_boots_bronze.exec()

    unilib.register_armour("unilib:armour_boots_bronze", "3d_armor:boots_bronze", mode, {
        -- From 3d_armor:boots_bronze
        description = S("Bronze Boots"),
        inventory_image = "unilib_armour_boots_bronze_inv.png",
        groups = {
            armour_feet = 1, armour_heal = 6, armour_use = 400, physics_gravity = 0.01,
            physics_speed = -0.01,
        },

        armour_groups = {fleshy = 10},
        damage_groups = {choppy = 2, cracky = 3, crumbly = 1, level = 2, snappy = 2},
    })
    unilib.register_craft_boots({
        -- From 3d_armor:boots_bronze
        part_name = "bronze",
        ingredient = "unilib:metal_bronze_ingot",
    })

end
