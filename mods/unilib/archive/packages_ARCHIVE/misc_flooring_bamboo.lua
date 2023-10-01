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
minetest.register_node("ethereal:bamboo_floor", {
	description = S("Bamboo Floor"),
	drawtype = "nodebox",
	tiles = {"ethereal_bamboo_floor.png"},
	wield_image = "ethereal_bamboo_floor.png",
	inventory_image = "ethereal_bamboo_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5}
	},
	selection_box = {type = "wallmounted"},
	groups = {snappy = 3, choppy = 3 , flammable = 2},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
	output = "ethereal:bamboo_floor 2",
	recipe = {
		{"ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo"}
	}
})
minetest.register_craft({
	output = "ethereal:bamboo_block",
	recipe = {
		{"ethereal:bamboo_floor"},
		{"ethereal:bamboo_floor"}
	}
})
]]--
