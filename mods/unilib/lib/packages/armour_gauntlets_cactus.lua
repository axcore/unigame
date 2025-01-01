---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_cactus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_cactus.init()

    return {
        description = "Cactus gloves",
        depends = {"item_string_ordinary", "plant_cactus_ordinary"},
    }

end

function unilib.pkg.armour_gauntlets_cactus.exec()

    unilib.register_armour(
        -- From 3d_armor_gloves:gloves_cactus
        "unilib:armour_gauntlets_cactus",
        "3d_armor_gloves:gloves_cactus",
        mode,
        {
            description = S("Cactus Gloves"),
            inventory_image = "unilib_armour_gauntlets_cactus_inv.png",
            groups = {armour_hands = 1, armour_heal = 0, armour_use = 1000},

            armour_groups = {fleshy = 5},
            damage_groups = {choppy = 2, cracky = 3, crumbly = 2, level = 1, snappy = 3},
        }
    )
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_cactus
        part_name = "cactus",
        ingredient = "unilib:plant_cactus_ordinary",
        minor_ingredient = "unilib:item_string_ordinary",
    })
    unilib.register_craft({
        -- From 3d_armor_gloves:gloves_cactus
        type = "fuel",
        recipe = "unilib:armour_gauntlets_cactus",
        burntime = 8,
    })

end
