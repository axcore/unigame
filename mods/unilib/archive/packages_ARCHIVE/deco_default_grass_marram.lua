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
    name = "default:marram_grass",
    deco_type = "simple",
    place_on = {"default:sand"},
    sidelen = 4,
    noise_params = {
        offset = -0.7,
        scale = 4.0,
        spread = {x = 16, y = 16, z = 16},
        seed = 513337,
        octaves = 1,
        persist = 0.0,
        flags = "absvalue, eased"
    },
    biomes = {"coniferous_forest_dunes", "grassland_dunes"},
    y_max = 6,
    y_min = 4,
    decoration = {
        "default:marram_grass_1",
        "default:marram_grass_2",
        "default:marram_grass_3",
    },
})
]]--
