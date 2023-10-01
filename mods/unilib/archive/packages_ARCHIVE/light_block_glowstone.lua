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
minetest.register_node("ethereal:glostone", {
	description = S("Glo Stone"),
	tiles = {"ethereal_glostone.png"},
	groups = {cracky = 3},
	light_source = 13,
	drop = "ethereal:glostone",
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "ethereal:glostone",
	recipe = {
		{"", "default:torch", ""},
		{"default:torch", "default:stone", "default:torch"},
		{"", "dye:yellow", ""}
	}
})
]]--
