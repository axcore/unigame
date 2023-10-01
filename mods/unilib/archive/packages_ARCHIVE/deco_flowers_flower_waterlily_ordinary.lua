---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    flowers
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function register_waterlily()
    minetest.register_decoration({
        name = "default:waterlily",
        deco_type = "simple",
        place_on = {"default:dirt"},
        sidelen = 16,
        noise_params = {
            offset = -0.12,
            scale = 0.3,
            spread = {x = 200, y = 200, z = 200},
            seed = 33,
            octaves = 3,
            persist = 0.7
        },
        biomes = {"rainforest_swamp", "savanna_shore", "deciduous_forest_shore"},
        y_max = 0,
        y_min = 0,
        decoration = "flowers:waterlily_waving",
        param2 = 0,
        param2_max = 3,
        place_offset_y = 1,
    })
end
]]--
