---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_bottle_glass_water = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_bottle_glass_water.init()

    return {
        description = "Bottle of water",
        depends = {"liquid_water_ordinary", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.vessel_bottle_glass_water.exec()

    unilib.register_node(
        -- From better_farming:glass_bottle_with_water
        "unilib:vessel_bottle_glass_water",
        "better_farming:glass_bottle_with_water",
        mode,
        {
            description = S("Bottle of Water"),
            tiles = {"unilib_vessel_bottle_glass_water.png"},
            groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_vessel_bottle_glass_water.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_vessel_bottle_glass_water.png",
        }
    )
    unilib.register_craft({
        -- From better_farming:glass_bottle_with_water
        output = "unilib:vessel_bottle_glass_water 4",
        recipe = {
            {"unilib:vessel_bottle_glass_empty", "unilib:liquid_water_ordinary_source"},
        },
    })

end
