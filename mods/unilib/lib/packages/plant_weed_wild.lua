---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plants
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_weed_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.plants.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_weed_wild.init()

    return {
        description = "Wild weed",
    }

end

function unilib.pkg.plant_weed_wild.exec()

    unilib.register_node("unilib:plant_weed_wild", nil, mode, {
        -- Code original to unilib, texture from plants
        description = S("Wild Weed"),
        tiles = {"unilib_plant_weed_wild.png"},
        -- N.B. flora = 1 not in original code
        groups = {attached_node = 1, flammable = 2, flora = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_weed_wild.png",
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, -3/16, 0.25},
        },
        sunlight_propagates = true,
        visual_scale = 1.3,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:plant_weed_wild", nil)

    unilib.register_decoration_generic("plants_plant_weed_wild", {
        -- Original to unilib, based on decoration in "plant_cotton_wild" package
        deco_type = "simple",
        decoration = "unilib:plant_weed_wild",

        noise_params = {
            octaves = 3,
            offset = -0.1,
            persist = 0.7,
            scale = 0.1,
            seed = 11948,      -- New random seed, generated for unilib
            spread = {x = 50, y = 50, z = 50},
        },
        sidelen = 16,
    })

end
