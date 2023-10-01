---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:sand"},
	sidelen = 80,
	fill_ratio = 0.005,
	biomes = {"great_barrier_reef"},
	y_min     = -10,
	y_max     = -2,
	decoration = "australia:sea_grass",
	flags = "force_placement",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:sand"},
	sidelen = 80,
	fill_ratio = 0.01,
	biomes = {"indian_ocean"},
	y_min     = -10,
	y_max     = -2,
	decoration = "australia:sea_grass",
	flags = "force_placement",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:sand"},
	sidelen = 80,
	fill_ratio = 0.02,
	biomes = {"timor_sea"},
	y_min     = -10,
	y_max     = -2,
	decoration = "australia:sea_grass",
	flags = "force_placement",
})
]]--
