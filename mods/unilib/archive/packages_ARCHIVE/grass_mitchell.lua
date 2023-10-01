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
minetest.register_node("australia:mitchell_grass", {
	description = "Astrebla pectinata: Mitchell Grass",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_mitchell_grass.png"},
	inventory_image = "aus_mitchell_grass.png",
	wield_image = "aus_mitchell_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

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
