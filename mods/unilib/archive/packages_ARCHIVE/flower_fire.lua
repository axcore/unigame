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
minetest.register_node("ethereal:fire_flower", {
	description = S("Fire Flower"),
	drawtype = "plantlike",
	tiles = { "ethereal_fire_flower.png" },
	inventory_image = "ethereal_fire_flower.png",
	wield_image = "ethereal_fire_flower.png",
	paramtype = "light",
	light_source = 5,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	damage_per_second = 2,
	groups = {snappy = 1, oddly_breakable_by_hand = 3, igniter = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 1 / 2, 5 / 16}
	},

	on_punch = function(pos, node, puncher)

		puncher:punch(puncher, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2}
		}, nil)
	end
})
minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:fire_flower",
	burntime = 20
})

minetest.register_craftitem("ethereal:fire_dust", {
	description = S("Fire Dust"),
	inventory_image = "ethereal_fire_dust.png"
})
minetest.register_craft({
	output = "ethereal:fire_dust 2",
	recipe = {{"ethereal:fire_flower"}}
})
minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:fire_dust",
	burntime = 10
})
]]--
