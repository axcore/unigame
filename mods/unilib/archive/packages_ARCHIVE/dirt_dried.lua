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
minetest.register_node("ethereal:dry_dirt", {
	description = S("Dried Dirt"),
	tiles = {"ethereal_dry_dirt.png"},
	is_ground_content = ethereal.cavedirt,
	groups = {crumbly = 3},
	sounds = default.node_sound_dirt_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "ethereal:dry_dirt",
	recipe = "default:dirt",
	cooktime = 3,
})
]]--
