---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    armor_expanded/armor_woven
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_leggings_woven = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_woven.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_leggings_woven.init()

    return {
        description = "Woven trousers",
        suggested = {
            "grass_ordinary",                   -- group:grass
        },
    }

end

function unilib.pkg.armour_leggings_woven.exec()

    unilib.register_armour("unilib:armour_leggings_woven", "armor_expanded:leggings_woven", mode, {
        -- From armor_expanded:leggings_woven
        description = S("Woven Trousers"),
        inventory_image = "unilib_armour_leggings_woven_inv.png",
        groups = {armour_heal = 0, armour_legs = 1, armour_use = 2500, flammable = 1},

        armour_groups = {fleshy = 8},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 1, snappy = 2},
    })
    unilib.register_craft_leggings({
        -- From armor_expanded:leggings_woven
        part_name = "woven",
        ingredient = "group:grass",
    })

end
