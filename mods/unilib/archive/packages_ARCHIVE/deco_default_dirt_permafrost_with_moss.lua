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
-- Tundra moss
minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:permafrost_with_stones"},
    sidelen = 4,
    noise_params = {
        offset = -0.8,
        scale = 2.0,
        spread = {x = 100, y = 100, z = 100},
        seed = 53995,
        octaves = 3,
        persist = 1.0
    },
    biomes = {"tundra"},
    y_max = 50,
    y_min = 2,
    decoration = "default:permafrost_with_moss",
    place_offset_y = -1,
    flags = "force_placement",
})
]]--
