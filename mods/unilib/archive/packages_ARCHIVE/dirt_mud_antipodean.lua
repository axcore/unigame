---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
--solid mud
minetest.register_node("aotearoa:mud", {
	description = "Mud",
	tiles = {
		"aotearoa_mud.png",
	},
	--walkable = false,
	--diggable = false,
	--pointable = false,
	--buildable_to = true,
	groups = {crumbly = 3, puts_out_fire = 1},
	drop = "aotearoa:silt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "aotearoa_mud", gain = 0.4},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
})

--this is so you sink in
minetest.register_node("aotearoa:mud_sinking", {
	description = "Sinking Mud",
	tiles = {
		{
			name = "aotearoa_mud_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	paramtype = "light",
	walkable = false,
	--diggable = false,
	--pointable = false,
	buildable_to = true,
	drowning = 1,
	post_effect_color = {a = 250, r = 20, g = 20, b = 20},
	groups = {crumbly = 3, puts_out_fire = 1, cools_lava = 1},
	drop = "aotearoa:silt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_water_footstep", gain = 0.2},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
})
]]--
