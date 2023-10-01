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
minetest.register_node("cropocalypse:dead_tree", {
	description = ("Dead Tree"),
	tiles = {"cropocalypse_dead_tree.png"},
	inventory_image = "cropocalypse_dead_tree.png",
	wield_image = "cropocalypse_dead_tree.png",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 3,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {grave_plants = 1, snappy = 3, attached_node = 1, flammable = 4},
	drop = "cropocalypse:dead_tree",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -8 / 16, -6 / 16, 6 / 16, 5 / 16, 6 / 16},
	},
})

minetest.register_decoration({
	name = "cropocalypse:dead_tree",
	deco_type = "simple",
	place_on = {"group:soil","group:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.2,
		spread = {x = 50, y = 50, z = 50},
		seed = 6310,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"grave"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:dead_tree",
})
]]--
