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
minetest.register_node("caverealms:glow_obsidian", {
	description = "Glowing Obsidian",
	tiles = {"caverealms_glow_obsidian.png"},
	is_ground_content = true,
	groups = {crumbly=1},
	light_source = 7,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})

minetest.register_node("caverealms:glow_obsidian_2", {
	description = "Hot Glow Obsidian",
	tiles = {"caverealms_glow_obsidian2.png"},
	is_ground_content = true,
	groups = {crumbly=1, hot=1},
	damage_per_second = 1,
	light_source = 9,
	sounds = default.node_sound_stone_defaults({
		footstep = {name="default_stone_footstep", gain=0.25},
	}),
})
]]--
