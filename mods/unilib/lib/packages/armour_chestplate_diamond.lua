---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_diamond
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_diamond.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_diamond.init()

    return {
        description = "Diamond chestplate",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.armour_chestplate_diamond.exec()

    unilib.register_armour(
        -- From 3d_armor:chestplate_diamond
        "unilib:armour_chestplate_diamond",
        "3d_armor:chestplate_diamond",
        mode,
        {
            description = S("Diamond Chestplate"),
            inventory_image = "unilib_armour_chestplate_diamond_inv.png",
            groups = {armour_heal = 12, armour_torso = 1, armour_use = 200},

            armour_groups = {fleshy = 20},
            damage_groups = {choppy = 1, cracky = 2, level = 3, snappy = 1},
        }
    )
    unilib.register_craft_chestplate({
        -- From 3d_armor:chestplate_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })

end
