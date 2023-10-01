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
minetest.register_node("cropocalypse:iris", {
	description = ("Iris"),
	tiles = {"cropocalypse_iris.png"},
	inventory_image = "cropocalypse_iris.png",
	wield_image = "cropocalypse_iris.png",
	drawtype = "plantlike",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {decorative_plants = 1, snappy = 3, attached_node = 1, flammable = 1},
	drop = "cropocalypse:iris",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
})
minetest.register_craft({
	output = "dye:violet 2",
	recipe = {
		{"cropocalypse:iris"}
	},
})

minetest.register_decoration({
	name = "cropocalypse:iris",
	deco_type = "simple",
	place_on = {"group:soil","group:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 10, y = 10, z = 10},
		seed = 6584,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"deciduous_forest","coniferous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:iris",
})
]]--
