---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_diamond = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_diamond.init()

    return {
        description = "Diamond gauntlets",
        depends = {"item_string_ordinary", "mineral_diamond"},
    }

end

function unilib.pkg.armour_gauntlets_diamond.exec()

    unilib.register_armour(
        -- From 3d_armor_gloves:gloves_diamond
        "unilib:armour_gauntlets_diamond",
        "3d_armor_gloves:gloves_diamond",
        mode,
        {
            description = S("Diamond Gauntlets"),
            inventory_image = "unilib_armour_gauntlets_diamond_inv.png",
            groups = {armour_hands = 1, armour_heal = 12, armour_use = 200},

            armour_groups = {fleshy = 15},
            damage_groups = {choppy = 1, cracky = 2, level = 3, snappy = 1},
        }
    )
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_diamond
        part_name = "diamond",
        ingredient = "unilib:mineral_diamond_gem",
        minor_ingredient = "unilib:item_string_ordinary",
    })

end
