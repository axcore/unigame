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
	y_max = 170,
	decoration = "australia:spinifex",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand"},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {"goldfields_esperence"},
	y_min = 6,
	y_max = 35,
	decoration = "australia:spinifex",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"australia:red_gravel"},
	sidelen = 80,
	fill_ratio = 0.02,
	biomes = {"pilbara"},
	y_min = 8,
	y_max = 31000,
	decoration = "australia:spinifex",
})
]]--
