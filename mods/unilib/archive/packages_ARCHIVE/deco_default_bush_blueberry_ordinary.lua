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
minetest.register_decoration({
    name = "default:blueberry_bush",
    deco_type = "schematic",
    place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
    sidelen = 16,
    noise_params = {
        offset = -0.004,
        scale = 0.01,
        spread = {x = 100, y = 100, z = 100},
        seed = 697,
        octaves = 3,
        persist = 0.7,
    },
    biomes = {"grassland", "snowy_grassland"},
    y_max = 31000,
    y_min = 1,
    place_offset_y = 1,
    schematic = minetest.get_modpath("default") .. "/schematics/blueberry_bush.mts",
    flags = "place_center_x, place_center_z",
})
]]--
