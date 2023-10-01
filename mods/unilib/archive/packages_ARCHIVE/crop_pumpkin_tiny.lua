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
farming.register_plant("cropocalypse:pumpkin_plant", {
	description = ("Pumpkin Seed"),
	harvest_description = ("Tiny Pumpkin"),
	inventory_image = "cropocalypse_pumpkin_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {crop_pumpkin = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_node("cropocalypse:pumpkin_plant", {
	description = "Tiny Pumpkin",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0, 0.25},
			{-0.0625, 0, -0.0625, 0.0625, 0.0625, 0.0625},
		}
	},
	tiles = {
		"cropocalypse_tiny_pumpkin_top.png",
		"cropocalypse_tiny_pumpkin_bottom.png",
		"cropocalypse_tiny_pumpkin.png",
		"cropocalypse_tiny_pumpkin.png",
		"cropocalypse_tiny_pumpkin.png",
		"cropocalypse_tiny_pumpkin.png"
	},
	groups = {pumpkin = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
	drop = "cropocalypse:pumpkin_plant",
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false
})

minetest.register_craft({
	type = "shapeless",
	output = "bonemeal:mulch",
	recipe = {"cropocalypse:pumpkin_plant"}
})
]]--
