---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_cactus_small = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farlands.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_cactus_small.init()

    return {
        description = "Small cactus",
    }

end

function unilib.pkg.plant_cactus_small.exec()

    unilib.register_node("unilib:plant_cactus_small", "mapgen:small_cactus", mode, {
        -- From farlands, mapgen:small_cactus
        description = S("Small Cactus"),
        tiles = {"unilib_plant_cactus_small.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_cactus_small.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })
    unilib.register_plant_in_pot("unilib:plant_cactus_small", "mapgen:small_cactus")

    unilib.register_node("unilib:plant_cactus_small_flowering", "mapgen:small_cactus_1", mode, {
        -- From farlands, mapgen:small_cactus_1
        description = S("Small Flowering Cactus"),
        tiles = {"unilib_plant_cactus_small_flowering.png"},
        groups = {attached_node = 1, flammable = 1, flora = 1, snappy = 3},
        sounds = unilib.sound_table.leaves,

        buildable_to = true,
        drawtype = "plantlike",
        inventory_image = "unilib_plant_cactus_small_flowering.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },
        sunlight_propagates = true,
        walkable = false,
    })

    unilib.register_decoration("farlands_plant_cactus_small", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_cactus_small",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.02,
            seed = 329,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

    unilib.register_decoration("farlands_plant_cactus_small_flowering", {
        -- From farlands, mapgen/mapgen.lua
        deco_type = "simple",
        decoration = "unilib:plant_cactus_small_flowering",

        noise_params = {
            octaves = 3,
            offset = 0,
            persist = 0.6,
            scale = 0.02,
            seed = 329,
            spread = {x = 200, y = 200, z = 200},
        },
        sidelen = 16,
    })

end
