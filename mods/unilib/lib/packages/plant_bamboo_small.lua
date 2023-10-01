---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_bamboo_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_bamboo_small.init()

    return {
        description = "Small bamboo plant",
    }

end

function unilib.pkg.plant_bamboo_small.exec()

    unilib.register_node("unilib:plant_bamboo_small", "mapgen:bamboo_small", mode, {
        -- From farlands, mapgen:bamboo_small
        description = S("Small Bamboo Plant"),
        tiles = {"unilib_plant_bamboo_small.png"},
        -- N.B. removed flora = 1 to prevent nonsensical spreading
        groups = {flammable = 1, oddly_breakable_by_hand = 1, snappy = 1},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_bamboo_small.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    -- (not compatible with flowerpots)

    unilib.register_node("unilib:plant_bamboo_small_top", "mapgen:bamboo_small_top", mode, {
        -- From farlands, mapgen:bamboo_small_top
        description = S("Top of Small Bamboo Plant"),
        tiles = {"unilib_plant_bamboo_small_top.png"},
        groups = {flammable = 1, flora = 1, oddly_breakable_by_hand = 1, snappy = 1},
        sounds = unilib.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_bamboo_small_top.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 2,
        walkable = false,
    })

    unilib.register_decoration("farlands_plant_bamboo_small_mini", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_bamboo_small",

        fill_ratio = 0.05,
        height = 3,
        noise_params = {
            octaves = 3,
            offset = 0.005,
            persist = 0.66,
            scale = 0.01,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

    unilib.register_decoration("farlands_plant_bamboo_small", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "schematic",
        -- (was "bamboo5.mts")
        schematic = unilib.path_mod .. "/mts/unilib_plant_bamboo_small.mts",

        flags = "place_center_x, place_center_z",
        noise_params = {
            octaves = 3,
            offset = 0.016,
            persist = 0.66,
            scale = 0.012,
            seed = 2,
            spread = {x = 250, y = 250, z = 250},
        },
        sidelen = 16,
    })

end
