---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    3d_armor_gloves
-- Code:    LGPL v2.1
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_gauntlets_wood = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table["3d_armor_gloves"].add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_gauntlets_wood.init()

    return {
        description = "Wooden gloves",
        depends = "item_string_ordinary",
    }

end

function unilib.pkg.armour_gauntlets_wood.exec()

    unilib.register_armour("unilib:armour_gauntlets_wood", "3d_armor_gloves:gloves_wood", mode, {
        -- From 3d_armor_gloves:gloves_wood
        description = S("Wooden Gloves"),
        inventory_image = "unilib_armour_gauntlets_wood_inv.png",
        groups = {armour_hands = 1, armour_heal = 0, armour_use = 2000, flammable = 1},

        armour_groups = {fleshy = 5},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 1, snappy = 2},
    })
    unilib.register_craft_gauntlets({
        -- From 3d_armor_gloves:gloves_wood
        part_name = "wood",
        ingredient = "group:wood",
        minor_ingredient = "unilib:item_string_ordinary",
    })
    unilib.register_craft({
        -- From 3d_armor_gloves:gloves_wood
        type = "fuel",
        recipe = "unilib:armour_gauntlets_wood",
        burntime = 4,
    })

end
