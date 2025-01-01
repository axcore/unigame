---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_gold
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_gold = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_gold.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_gold.init()

    return {
        description = "Gold chestplate",
        depends = "metal_gold",
    }

end

function unilib.pkg.armour_chestplate_gold.exec()

    unilib.register_armour("unilib:armour_chestplate_gold", "3d_armor:chestplate_gold", mode, {
        -- From 3d_armor:chestplate_gold
        description = S("Gold Chestplate"),
        inventory_image = "unilib_armour_chestplate_gold_inv.png",
        groups = {
            armour_heal = 6, armour_torso = 1, armour_use = 300, physics_gravity = 0.05,
            physics_speed = -0.05,
        },

        armour_groups = {fleshy = 15},
        damage_groups = {choppy = 2, cracky = 1, crumbly = 3, level = 2, snappy = 2},
    })
    unilib.register_craft_chestplate({
        -- From 3d_armor:chestplate_gold
        part_name = "gold",
        ingredient = "unilib:metal_gold_ingot",
    })

end
