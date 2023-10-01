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
local function register_grass_decoration(offset, scale, length)
    minetest.register_decoration({
        name = "default:grass_" .. length,
        deco_type = "simple",
        place_on = {"default:dirt_with_grass"},
        sidelen = 16,
        noise_params = {
            offset = offset,
            scale = scale,
            spread = {x = 200, y = 200, z = 200},
            seed = 329,
            octaves = 3,
            persist = 0.6
        },
        biomes = {"grassland", "deciduous_forest"},
        y_max = 31000,
        y_min = 1,
        decoration = "default:grass_" .. length,
    })
end

register_grass_decoration(-0.03,  0.09,  5)
register_grass_decoration(-0.015, 0.075, 4)
register_grass_decoration(0,      0.06,  3)
register_grass_decoration(0.015,  0.045, 2)
register_grass_decoration(0.03,   0.03,  1)
]]--
