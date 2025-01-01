---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    armor_expanded/armor_woven
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.armour_chestplate_woven = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.armor_woven.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.armour_chestplate_woven.init()

    return {
        description = "Woven tunic",
        suggested = {
            "grass_ordinary",                   -- group:grass
        },
    }

end

function unilib.pkg.armour_chestplate_woven.exec()

    unilib.register_armour(
        -- From armor_expanded:chestplate_woven
        "unilib:armour_chestplate_woven",
        "armor_expanded:chestplate_woven",
        mode,
        {
            description = S("Woven Tunic"),
            inventory_image = "unilib_armour_chestplate_woven_inv.png",
            groups = {armour_heal = 0, armour_torso = 1, armour_use = 2500, flammable = 1},

            armour_groups = {fleshy = 8},
            damage_groups = {choppy = 3, cracky = 3, crumbly = 2, level = 1, snappy = 2},
        }
    )
    unilib.register_craft_chestplate({
        -- From armor_expanded:chestplate_woven
        part_name = "woven",
        ingredient = "group:grass",
    })

end
