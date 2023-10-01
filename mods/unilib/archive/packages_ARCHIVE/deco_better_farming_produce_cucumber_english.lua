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
	name = "better_farming:cucumber_4",
	deco_type = "simple",
	place_on = {"default:desert_sand", "default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 3785,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"desert", "coniferous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = "better_farming:cucumber_4",
	param2 = 3,
})
]]--
