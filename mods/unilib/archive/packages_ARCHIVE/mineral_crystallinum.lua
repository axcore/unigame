---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:crystal_spike", {
	description = S("Crystal Spike"),
	drawtype = "plantlike",
	tiles = {"ethereal_crystal_spike.png"},
	inventory_image = "ethereal_crystal_spike.png",
	wield_image = "ethereal_crystal_spike.png",
	paramtype = "light",
	light_source = 7,
	sunlight_propagates = true,
	walkable = true,
	damage_per_second = 1,
	groups = {cracky = 1, falling_node = 1, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16},
	},
	node_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0, 5 / 16},
	}
})

minetest.register_craftitem("ethereal:crystal_ingot", {
	description = S("Crystal Ingot"),
	inventory_image = "ethereal_crystal_ingot.png",
	wield_image = "ethereal_crystal_ingot.png"
})
minetest.register_craft({
	type = "shapeless",
	output = "ethereal:crystal_ingot",
	recipe = {
		"default:mese_crystal", "ethereal:crystal_spike",
		"ethereal:crystal_spike", "default:mese_crystal", "bucket:bucket_water"
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})
minetest.register_craft({
	output = "ethereal:crystal_ingot 9",
	recipe = {{"ethereal:crystal_block"}}
})

minetest.register_node("ethereal:crystal_block", {
	description = S("Crystal Block"),
	tiles = {"ethereal_crystal_block.png"},
	light_source = 9,
	is_ground_content = false,
	groups = {cracky = 1, level = 2, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_glass_defaults()
})
minetest.register_craft({
	output = "ethereal:crystal_block",
	recipe = {
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"}
	}
})
do_stair(
	"Crystal Block",
	"crystal_block",
	"ethereal:crystal_block",
	{cracky = 1, level = 2, puts_out_fire = 1, cools_lava = 1},
	{"ethereal_crystal_block.png"},
	default.node_sound_glass_defaults())
]]--
