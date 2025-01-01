---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_crystal
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_crystallite = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_crystal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_crystallite.init()

    return {
        description = "Crystallite chestplate",
        depends = "mineral_crystallite",
    }

end

function unilib.pkg.armour_chestplate_crystallite.exec()

    unilib.register_armour(
        -- From 3d_armor:chestplate_crystal
        "unilib:armour_chestplate_crystallite",
        "3d_armor:chestplate_crystal",
        mode,
        {
            description = S("Crystallite Chestplate"),
            inventory_image = "unilib_armour_chestplate_crystallite_inv.png",
            groups = {armour_fire = 1, armour_heal = 12, armour_torso = 1, armour_use = 100},

            armour_groups = {fleshy = 20},
            damage_groups = {cracky = 2, level = 3, snappy = 1},
        }
    )
    unilib.register_craft_chestplate({
        -- From 3d_armor:chestplate_crystal
        part_name = "crystallite",
        ingredient = "unilib:mineral_crystallite_ingot",
    })

end
