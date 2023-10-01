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
minetest.register_node("cropocalypse:skunk_cabbage", {
	description = ("Skunk Cabbage"),
	tiles = {"cropocalypse_skunk_cabbage.png"},
	inventory_image = "cropocalypse_skunk_cabbage.png",
	wield_image = "cropocalypse_skunk_cabbage.png",
	drawtype = "plantlike",
	waving = 1,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {decorative_plants = 1, snappy = 3, attached_node = 1, flammable = 1},
	drop = "cropocalypse:skunk_cabbage",
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	},
})
minetest.register_craft({
	output = "dye:yellow 2",
	recipe = {
		{"cropocalypse:skunk_cabbage"}
	},
})

minetest.register_decoration({
	name = "cropocalypse:skunk_cabbage",
	deco_type = "simple",
	place_on = {"group:soil","group:sand","default:permafrost_with_stones","default:permafrost_with_moss"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 10, y = 10, z = 10},
		seed = 4907,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"deciduous_forest","tundra"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:skunk_cabbage",
})
]]--
