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
minetest.register_node("cropocalypse:pumpkin", {
	description = "Pumpkin",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"cropocalypse_pumpkin_top.png",
		"cropocalypse_pumpkin_bottom.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png"
	},
	groups = {pumpkin = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
	drop = "cropocalypse:pumpkin",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

minetest.register_node("cropocalypse:pumpkin_wild", {
	description = "Pumpkin",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		}
	},
	tiles = {
		"cropocalypse_pumpkin_top.png",
		"cropocalypse_pumpkin_bottom.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png",
		"cropocalypse_pumpkin.png"
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1, not_in_creative_inventory = 1},
	drop = "cropocalypse:pumpkin",
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

minetest.register_decoration({
	name = "cropocalypse:pumpkin_wild",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 6588,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"grassland"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:pumpkin_wild",
})

minetest.register_craftitem("cropocalypse:pumpkin_chunk", {
	description = ("Pumpkin Chunk"),
	inventory_image = "cropocalypse_pumpkin_chunk.png",
	wield_image = "cropocalypse_pumpkin_chunk.png",
	paramtype = "meshoptions",
	groups = {food_pumpkin = 1, flammable = 4},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	output = "cropocalypse:pumpkin",
	recipe = {
		{"cropocalypse:pumpkin_plant", "cropocalypse:pumpkin_plant", "cropocalypse:pumpkin_plant"},
		{"cropocalypse:pumpkin_plant", "cropocalypse:pumpkin_plant", "cropocalypse:pumpkin_plant"},
		{"cropocalypse:pumpkin_plant", "cropocalypse:pumpkin_plant", "cropocalypse:pumpkin_plant"},
	}
})
minetest.register_craft({
	output = "cropocalypse:pumpkin",
	recipe = {
		{"cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk"},
		{"cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk"},
		{"cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk", "cropocalypse:pumpkin_chunk"},
	}
})
minetest.register_craft({
	output = "cropocalypse:pumpkin_chunk 9",
	recipe = {
		{"cropocalypse:pumpkin"},
	}
})
minetest.register_craft({
	output = "cropocalypse:seed_pumpkin_plant",
	recipe = {
		{"cropocalypse:pumpkin_chunk"},
	}
})
]]--
