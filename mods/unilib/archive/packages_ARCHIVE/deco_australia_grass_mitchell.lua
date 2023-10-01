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
	place_on = {"australia:red_dirt"},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {"central_australia"},
	y_min = 37,
	y_max = 180,
	decoration = "australia:mitchell_grass",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {"gulf_of_carpentaria"},
	y_min = 12,
	y_max = 35,
	decoration = "australia:mitchell_grass",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"australia:red_gravel"},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {"pilbara"},
	y_min = 6,
	y_max = 31000,
	decoration = "australia:mitchell_grass",
})
]]--
