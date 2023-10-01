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
minetest.register_node("ethereal:seaweed", {
	description = S("Seaweed"),
	drawtype = "plantlike",
	tiles = {"ethereal_seaweed.png"},
	inventory_image = "ethereal_seaweed.png",
	wield_image = "ethereal_seaweed.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {food_seaweed = 1, snappy = 3, flammable = 3},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end
})
minetest.register_craft( {
	type = "shapeless",
	output = "dye:dark_green 3",
	recipe = {"ethereal:seaweed"}
})
]]--
