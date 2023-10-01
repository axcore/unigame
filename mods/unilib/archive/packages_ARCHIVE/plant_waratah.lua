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
minetest.register_node("australia:waratah", {
	description = "Telopea speciosissima: Waratah",
	drawtype = "allfaces_optional",
	visual_scale = 1.0,
	tiles = { "aus_waratah.png"},
	inventory_image = { "aus_waratah.png"},
	wield_image = { "aus_waratah.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.005,
	biomes = {"eastern_coasts"},
	y_min = 6,
	y_max = 35,
	schematic = {
		size = { x = 2, y = 3, z = 2},
		data = {
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
			{ name = "australia:waratah", param1 = 255, param2 = 0 },
		},
	},
	flags = "force_placement",
})
]]--
