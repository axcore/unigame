---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    armor_expanded/armor_leather
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_boots_leather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_leather.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_boots_leather.init()

    return {
        description = "Leather boots",
    }

end

function unilib.pkg.armour_boots_leather.exec()

    unilib.register_armour("unilib:armour_boots_leather", "armor_expanded:boots_leather", mode, {
        -- From armor_expanded:boots_leather
        description = S("Leather Boots"),
        inventory_image = "unilib_armour_boots_leather_inv.png",
        groups = {armour_feet = 1, armour_heal = 0, armour_use = 800, flammable = 1},

        armour_groups = {fleshy = 7},
        damage_groups = {choppy = 2, cracky = 3, crumbly = 2, level = 1, snappy = 2},
    })
    unilib.register_craft_boots({
        -- From armor_expanded:boots_leather
        part_name = "leather",
        ingredient = "group:leather",
    })
    unilib.register_external_ingredient("unilib:armour_leggings_leather", {
        "group:leather",
    })

end