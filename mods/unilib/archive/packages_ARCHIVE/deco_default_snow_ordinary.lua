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
-- Tundra patchy snow
minetest.register_decoration({
    deco_type = "simple",
    place_on = {
        "default:permafrost_with_moss",
        "default:permafrost_with_stones",
        "default:stone",
        "default:gravel"
    },
    sidelen = 4,
    noise_params = {
        offset = 0,
        scale = 1.0,
        spread = {x = 100, y = 100, z = 100},
        seed = 172555,
        octaves = 3,
        persist = 1.0
    },
    biomes = {"tundra", "tundra_beach"},
    y_max = 50,
    y_min = 1,
    decoration = "default:snow",
})
]]--
