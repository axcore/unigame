---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    australia
-- Code:    GPLv3/LGPL 2.1/BSD
-- Media:   CC by 3.0/CC BY-SA 3.0/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("australia:mangrove_mud", {
	description = "Mangrove Mud",
	tiles = {"aus_mangrove_mud.png"},
	groups = {crumbly=2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="aus_mangrove_mud", gain=0.4},
		dug = {name="aus_mangrove_mud", gain=0.4},
	}),
})
]]--
