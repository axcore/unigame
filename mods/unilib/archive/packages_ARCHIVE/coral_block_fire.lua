---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xocean
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.override_item("default:coral_orange", {
 	description = "Fire Coral Block",
	tiles = {"xocean_coral_fire.png"},
	groups = {cracky = 3},
	drop = "xocean:fire_skeleton",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("xocean:fire_skeleton", {
 	description = "Fire Coral Skeleton Block",
	tiles = {"xocean_coral_fire_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
]]--
