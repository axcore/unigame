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
minetest.register_craftitem("ethereal:charcoal_lump", {
	description = S("Lump of Charcoal"),
	inventory_image = "ethereal_charcoal_lump.png"
})
minetest.register_craft({
	output = "ethereal:charcoal_lump 2",
	type = "cooking",
	recipe = "group:tree",
	cooktime = 4
})
minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:charcoal_lump",
	burntime = 10
})
minetest.register_craft({
	output = "ethereal:charcoal_lump 2",
	recipe = {
		{"ethereal:scorched_tree"}
	}
})
minetest.register_craft({
	output = "default:torch 4",
	recipe = {
		{"ethereal:charcoal_lump"},
		{"default:stick"}
	}
})
]]--
