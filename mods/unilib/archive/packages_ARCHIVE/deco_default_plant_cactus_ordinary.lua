---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Cactus
minetest.register_decoration({
    name = "default:cactus",
    deco_type = "simple",
    place_on = {"default:desert_sand"},
    sidelen = 16,
    noise_params = {
        offset = -0.0003,
        scale = 0.0009,
        spread = {x = 200, y = 200, z = 200},
        seed = 230,
        octaves = 3,
        persist = 0.6
    },
    biomes = {"desert"},
    y_max = 31000,
    y_min = 4,
    decoration = "default:cactus",
    height = 2,
    height_max = 5,
})

-- Large cactus
minetest.register_decoration({
    name = "default:large_cactus",
    deco_type = "schematic",
    place_on = {"default:desert_sand"},
    sidelen = 16,
    noise_params = {
        offset = -0.0003,
        scale = 0.0009,
        spread = {x = 200, y = 200, z = 200},
        seed = 230,
        octaves = 3,
        persist = 0.6
    },
    biomes = {"desert"},
    y_max = 31000,
    y_min = 4,
    schematic = minetest.get_modpath("default") .. "/schematics/large_cactus.mts",
    flags = "place_center_x, place_center_z",
    rotation = "random",
})
]]--
