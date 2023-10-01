---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    caverealms
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("caverealms:hot_cobble", {
	description = "Hot Cobble",
	tiles = {"caverealms_hot_cobble.png"},
	is_ground_content = true,
	groups = {crumbly=2, hot=1},
	damage_per_second = 1,
	light_source = 3,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})
]]--
