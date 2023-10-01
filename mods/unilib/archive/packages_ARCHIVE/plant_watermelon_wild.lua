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
minetest.register_node("cropocalypse:watermelon", {
	description = "Watermelon",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"cropocalypse_watermelon_top_bottom.png",
		"cropocalypse_watermelon_top_bottom.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png"
	},
	groups = {watermelon = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
	drop = "cropocalypse:watermelon",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

minetest.register_node("cropocalypse:watermelon_wild", {
	description = "Watermelon",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"cropocalypse_watermelon_top_bottom.png",
		"cropocalypse_watermelon_top_bottom.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png",
		"cropocalypse_watermelon.png"
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1, not_in_creative_inventory = 1},
	drop = "cropocalypse:watermelon",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

minetest.register_decoration({
	name = "cropocalypse:watermelon_wild",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 1374,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"rainforest"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:watermelon_wild",
})

minetest.register_craftitem("cropocalypse:watermelon_slice", {
	description = ("Watermelon Slice"),
	inventory_image = "cropocalypse_watermelon_slice.png",
	wield_image = "cropocalypse_watermelon_slice.png",
	paramtype = "meshoptions",
	groups = {food_watermelon = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	output = "cropocalypse:watermelon",
	recipe = {
		{"cropocalypse:watermelon_plant", "cropocalypse:watermelon_plant", "cropocalypse:watermelon_plant"},
		{"cropocalypse:watermelon_plant", "cropocalypse:watermelon_plant", "cropocalypse:watermelon_plant"},
		{"cropocalypse:watermelon_plant", "cropocalypse:watermelon_plant", "cropocalypse:watermelon_plant"},
	}
})
minetest.register_craft({
	output = "cropocalypse:watermelon",
	recipe = {
		{"cropocalypse:watermelon_slice", "cropocalypse:watermelon_slice", "cropocalypse:watermelon_slice"},
		{"cropocalypse:watermelon_slice", "cropocalypse:watermelon_slice", "cropocalypse:watermelon_slice"},
		{"cropocalypse:watermelon_slice", "cropocalypse:watermelon_slice", "cropocalypse:watermelon_slice"},
	}
})
minetest.register_craft({
	output = "cropocalypse:watermelon_slice 9",
	recipe = {
		{"cropocalypse:watermelon"},
	}
})
minetest.register_craft({
	output = "cropocalypse:seed_watermelon_plant",
	recipe = {
		{"cropocalypse:watermelon_slice"},
	}
})
]]--
