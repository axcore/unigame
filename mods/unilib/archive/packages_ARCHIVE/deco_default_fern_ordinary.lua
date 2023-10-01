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
local function register_fern_decoration(seed, length)
    minetest.register_decoration({
        name = "default:fern_" .. length,
        deco_type = "simple",
        place_on = {"default:dirt_with_coniferous_litter"},
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = 0.2,
            spread = {x = 100, y = 100, z = 100},
            seed = seed,
            octaves = 3,
            persist = 0.7
        },
        biomes = {"coniferous_forest"},
        y_max = 31000,
        y_min = 6,
        decoration = "default:fern_" .. length,
    })
end

register_fern_decoration(14936, 3)
register_fern_decoration(801,   2)
register_fern_decoration(5,     1)
]]--
