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
minetest.register_node("xocean:tube_block", {
	description = "Tube Coral Block",
	tiles = {"xocean_coral_tube.png"},
	groups = {cracky = 3},
	drop = "xocean:tube_skeleton",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("xocean:tube_skeleton", {
	description = "Tube Coral Skeleton Block",
	tiles = {"xocean_coral_tube_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
]]--
