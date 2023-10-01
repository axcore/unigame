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
minetest.register_node("xocean:bubble_block", {
	description = "Bubble Coral Block",
	tiles = {"xocean_coral_bubble.png"},
	groups = {cracky = 3},
	drop = "xocean:bubble_skeleton",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("xocean:bubble_skeleton", {
	description = "Bubble Coral Skeleton Block",
	tiles = {"xocean_coral_bubble_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
]]--
