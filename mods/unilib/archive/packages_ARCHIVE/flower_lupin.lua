---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cropocalypse:lupine", {
	description = ("Lupine"),
	tiles = {"cropocalypse_lupine.png"},
	inventory_image = "cropocalypse_lupine.png",
	wield_image = "cropocalypse_lupine.png",
	drawtype = "plantlike",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {decorative_plants = 1, snappy = 3, attached_node = 1, flammable = 1},
	drop = "cropocalypse:lupine",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
})
minetest.register_craft({
	output = "dye:violet 2",
	recipe = {
		{"cropocalypse:lupine"}
	},
})

minetest.register_decoration({
	name = "cropocalypse:lupine",
	deco_type = "simple",
	place_on = {"group:soil","group:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 10, y = 10, z = 10},
		seed = 5557,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"grassland","coniferous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:lupine",
})
]]--
