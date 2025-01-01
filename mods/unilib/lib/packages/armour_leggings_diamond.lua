---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_diamond
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_diamond.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_diamond.init()

    return {
        description = "Diamond leggings",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.armour_leggings_diamond.exec()

    unilib.register_armour("unilib:armour_leggings_diamond", "3d_armor:leggings_diamond", mode, {
        -- From 3d_armor:leggings_diamond
        description = S("Diamond Leggings"),
        inventory_image = "unilib_armour_leggings_diamond_inv.png",
        groups = {armour_heal = 12, armour_legs = 1, armour_use = 200},

        armour_groups = {fleshy = 20},
        damage_groups = {choppy = 1, cracky = 2, level = 3, snappy = 1},
    })
    unilib.register_craft_leggings({
        -- From 3d_armor:leggings_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })

end
