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
farming.register_plant("cropocalypse:watermelon_plant", {
	description = ("Watermelon Seed"),
	harvest_description = ("Tiny Watermelon"),
	inventory_image = "cropocalypse_watermelon_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {crop_watermelon = 1, flammable = 4},
	place_param2 = 3,
})

minetest.register_node("cropocalypse:watermelon_plant", {
	description = "Tiny Watermelon",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0, 0.25},
		}
	},
	tiles = {
		"cropocalypse_tiny_watermelon_top_bottom.png",
		"cropocalypse_tiny_watermelon_top_bottom.png",
		"cropocalypse_tiny_watermelon.png",
		"cropocalypse_tiny_watermelon.png",
		"cropocalypse_tiny_watermelon.png",
		"cropocalypse_tiny_watermelon.png"
	},
	groups = {watermelon = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
	drop = "cropocalypse:watermelon_plant",
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
	recipe = {"cropocalypse:watermelon_plant"}
})
]]--
