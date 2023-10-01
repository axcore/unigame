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
minetest.register_node("xocean:brain_block", {
	description = "Brain Coral Block",
	tiles = {"xocean_coral_brain.png"},
	groups = {cracky = 3},
	drop = "xocean:brain_skeleton",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("xocean:brain_skeleton", {
	description = "Brain Coral Skeleton Block",
	tiles = {"xocean_coral_brain_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
]]--
