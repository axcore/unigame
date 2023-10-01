---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.grass_bamboo = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.grass_bamboo.init()

    return {
        description = "Bamboo grass",
    }

end

function unilib.pkg.grass_bamboo.exec()

    unilib.register_node("unilib:grass_bamboo", "mapgen:bamboo_grass", mode, {
        -- From farlands, mapgen:bamboo_grass
        description = S("Bamboo Grass"),
        tiles = {"unilib_grass_bamboo.png"},
        -- N.B. grass = 1, bamboo_grass = 1 not in original code
        groups = {
            bamboo_grass = 1, flammable = 1, flora = 1, grass = 1, oddly_breakable_by_hand = 1,
            snappy = 1,
        },
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_grass_bamboo.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.3, 0.2},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:grass_bamboo", "mapgen:bamboo_grass")

    unilib.register_decoration("farlands_grass_bamboo", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:grass_bamboo",

        height = 1,
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

end
