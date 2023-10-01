---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	name = "cropocalypse:skunk_cabbage",
	deco_type = "simple",
	place_on = {"group:soil","group:sand","default:permafrost_with_stones","default:permafrost_with_moss"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 10, y = 10, z = 10},
		seed = 4907,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"deciduous_forest","tundra"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:skunk_cabbage",
})
]]--
