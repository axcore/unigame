---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    armor_expanded/armor_leather
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_leather = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_leather.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_leather.init()

    return {
        description = "Leather tunic",
    }

end

function unilib.pkg.armour_chestplate_leather.exec()

    unilib.register_armour(
        -- From armor_expanded:chestplate_leather
        "unilib:armour_chestplate_leather",
        "armor_expanded:chestplate_leather",
        mode,
        {
            description = S("Leather Tunic"),
            inventory_image = "unilib_armour_chestplate_leather_inv.png",
            groups = {armour_heal = 0, armour_torso = 1, armour_use = 800, flammable = 1},

            armour_groups = {fleshy = 12},
            damage_groups = {choppy = 2, cracky = 3, crumbly = 2, level = 1, snappy = 2},
        }
    )
    unilib.register_craft_chestplate({
        -- From armor_expanded:chestplate_leather
        part_name = "leather",
        ingredient = "group:leather",
    })
    unilib.register_external_ingredient("unilib:armour_leggings_leather", {
        "group:leather",
    })

end
