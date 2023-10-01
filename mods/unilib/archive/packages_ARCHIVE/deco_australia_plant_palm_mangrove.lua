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
	deco_type = "schematic",
	place_on = {"australia:mangrove_mud",
		"default:dirt"},
	sidelen = 80,
	fill_ratio = 0.3,
	biomes = {"mangroves"},
	y_min = 1,
	y_max = 3,
	schematic = {
		size = { x = 1, y = 4, z = 1},
		data = {
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:mangrove_palm_trunk", param1 = 255, param2 = 0 },
			{ name = "australia:mangrove_palm_leaf_bot", param1 = 255, param2 = 0 },
			{ name = "australia:mangrove_palm_leaf_top", param1 = 255, param2 = 0 },
		},
	},
	flags = "force_placement",
})
]]--
