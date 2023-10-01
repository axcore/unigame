---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local function register_snow_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_snow",},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"icesheet", "taiga", "snowy_grassland",},
		y_min = 1,
		y_max = 31000,
		decoration = "mapgen:snow_grass_" .. length,
	})
end

	register_snow_grass_decoration(-0.03,  0.09,  5)
	register_snow_grass_decoration(-0.015, 0.075, 4)
	register_snow_grass_decoration(0,      0.06,  3)
	register_snow_grass_decoration(0.015,  0.045, 2)
	register_snow_grass_decoration(0.03,   0.03,  1)
]]--
