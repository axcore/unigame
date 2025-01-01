---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    armor_expanded/armor_woven
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_woven = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_woven.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_woven.init()

    return {
        description = "Woven boots",
        suggested = {
            "grass_ordinary",                   -- group:grass
        },
    }

end

function unilib.pkg.armour_boots_woven.exec()

    unilib.register_armour("unilib:armour_boots_woven", "armor_expanded:boots_woven", mode, {
        -- From armor_expanded:boots_woven
        description = S("Woven Boots"),
        inventory_image = "unilib_armour_boots_woven_inv.png",
        groups = {armour_feet = 1, armour_heal = 0, armour_use = 2500, flammable = 1},

        armour_groups = {fleshy = 3},
        damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 1, snappy = 2},
    })
    unilib.register_craft_boots({
        -- From armor_expanded:boots_woven
        part_name = "woven",
        ingredient = "group:grass",
    })

end
