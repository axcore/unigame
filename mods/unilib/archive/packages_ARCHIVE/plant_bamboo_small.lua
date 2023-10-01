---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:bamboo_small", {
	description = "Small Bamboo",
	drawtype = "plantlike",
	tiles = {"mapgen_bamboo_small.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	inventory_image = "mapgen_bamboo_small.png",
	groups = {snappy=1, flammable=1, oddly_breakable_by_hand=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})

minetest.register_node("mapgen:bamboo_small_top", {
	description = "Small Bamboo Top",
	drawtype = "plantlike",
	tiles = {"mapgen_bamboo_small_top.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	visual_scale = 2,
	inventory_image = "mapgen_bamboo_small_top.png",
	groups = {snappy=1, flammable=1, oddly_breakable_by_hand=1, flora=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}
	},
	walkable = false,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	noise_params = {
			offset = 0.005,
			scale = 0.01,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
	},
	fill_ratio = 0.05,
	biomes = {"bamboo_forest",},
	decoration = "mapgen:bamboo_small",
	height = 3,
})

    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.016,
			scale = 0.012,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"bamboo_forest",},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/bamboo5.mts",
		flags = "place_center_x, place_center_z",
	})
]]--
