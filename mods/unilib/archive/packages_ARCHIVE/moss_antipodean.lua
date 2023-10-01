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
minetest.register_node("australia:moss", {
	description = "Moss",
	drawtype = "nodebox",
	tiles = {"aus_moss.png"},
	inventory_image = "aus_moss.png",
	wield_image = "aus_moss.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},
	groups = {snappy = 3,flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.06,
	biomes = {"great_dividing_range"},
	y_min = 36,
	y_max = 31000,
	decoration = "australia:moss",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.9,
	biomes = {"tasmania"},
	y_min = 8,
	y_max = 31000,
	decoration = "australia:moss",
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.07,
	biomes = {"victorian_forests"},
	y_min = 36,
	y_max = 200,
	decoration = "australia:moss",
})

minetest.register_node("australia:moss_with_fungus", {
	description = "Moss with Fungus",
	drawtype = "nodebox",
	tiles = {"aus_moss_fungus.png"},
	inventory_image = "aus_moss_fungus.png",
	wield_image = "aus_moss_fungus.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},
	groups = {snappy = 3,flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.02,
	biomes = {"tasmania"},
	y_min = 8,
	y_max = 31000,
	decoration = "australia:moss_with_fungus",
})
]]--
