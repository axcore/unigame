---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	name = "better_farming:millet_3",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 4219,
		octaves = 3,
		persist = 1.1
	},
	biomes = {"deciduous_forest_ocean", "grassland_dunes", "grassland"},
	y_max = 15,
	y_min = 0,
	decoration = "better_farming:millet_3",
	param2 = 3,
})
]]--
