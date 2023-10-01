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
minetest.register_node("ethereal:bush3", {
	drawtype = "allfaces_optional",
	description = S("Bush #3"),
	tiles = {"default_pine_needles.png"},
	paramtype = "light",
	walkable = true,
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults()
})
minetest.register_craft({
	output = "ethereal:bush3",
	recipe = {
		{"group:leaves", "group:leaves", "group:leaves"},
		{"group:leaves", "default:pine_needles", "group:leaves"},
		{"group:leaves", "group:leaves", "group:leaves"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:bush3",
	burntime = 1
})
]]--
