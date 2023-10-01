---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt",
			"default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.09,
		spread = {x = 100, y = 100, z = 100},
		seed = 760,
		octaves = 3,
		persist = 0.6
	},
	y_min = 5,
	y_max = 35,
	decoration = {
		"farming:chili_8", "farming:garlic_5", "farming:pepper_5", "farming:pepper_6",
		"farming:onion_5", "farming:hemp_7", "farming:pepper_7", "farming:soy_5"
	},
	spawn_by = "group:tree",
	num_spawn_by = 1
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.06,
		spread = {x = 100, y = 100, z = 100},
		seed = 917,
		octaves = 3,
		persist = 0.6
	},
	y_min = 18,
	y_max = 30,
	decoration = {"farming:pineapple_8", "farming:soy_5"}
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"ethereal:grove_dirt"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.06,
		spread = {x = 100, y = 100, z = 100},
		seed = 448,
		octaves = 3,
		persist = 0.6
	},
	y_min = 15,
	y_max = 40,
	decoration = {"farming:artichoke_5"},
	spawn_by = "group:tree",
	num_spawn_by = 1
})
]]--
