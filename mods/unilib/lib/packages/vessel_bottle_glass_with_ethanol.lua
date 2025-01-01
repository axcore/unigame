---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_with_ethanol = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_with_ethanol.init()

    return {
        description = "Bottle of ethanol",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "produce_corn_normal",              -- group:food_corn
        },
    }

end

function unilib.pkg.vessel_bottle_glass_with_ethanol.exec()

    unilib.register_node(
        -- From farming:bottle_ethanol
        "unilib:vessel_bottle_glass_with_ethanol",
        "farming:bottle_ethanol",
        mode,
        {
            description = S("Bottle of Ethanol"),
            tiles = {"unilib_vessel_bottle_glass_with_ethanol.png"},
            groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_vessel_bottle_glass_with_ethanol.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_vessel_bottle_glass_with_ethanol.png",
        }
    )
    unilib.register_craft( {
        -- From farming:bottle_ethanol
        output = "unilib:vessel_bottle_glass_with_ethanol",
        recipe = {
            {"group:food_corn", "group:food_corn", "group:food_corn"},
            {"group:food_corn", "unilib:vessel_bottle_glass_empty", "group:food_corn"},
            {"group:food_corn", "group:food_corn", "group:food_corn"},
        },
    })
    unilib.register_craft({
        -- From farming:bottle_ethanol
        type = "fuel",
        recipe = "unilib:vessel_bottle_glass_with_ethanol",
        burntime = 80,
        replacements = {
            {"unilib:vessel_bottle_glass_with_ethanol", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
