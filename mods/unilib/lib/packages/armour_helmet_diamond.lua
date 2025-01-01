---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor/armor_diamond
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_helmet_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_diamond.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_helmet_diamond.init()

    return {
        description = "Diamond helmet",
        depends = "mineral_diamond",
    }

end

function unilib.pkg.armour_helmet_diamond.exec()

    unilib.register_armour("unilib:armour_helmet_diamond", "3d_armor:helmet_diamond", mode, {
        -- From 3d_armor:helmet_diamond
        description = S("Diamond Helmet"),
        inventory_image = "unilib_armour_helmet_diamond_inv.png",
        groups = {armour_head = 1, armour_heal = 12, armour_use = 200},

        armour_groups = {fleshy = 15},
        damage_groups = {choppy = 1, cracky = 2, level = 3, snappy = 1},
    })
    unilib.register_craft_helmet({
        -- From 3d_armor:helmet_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
    })

end
