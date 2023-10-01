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
minetest.register_node("aotearoa:boiling_mud_source", {
	description = "Boiling Mud Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "aotearoa_boiling_mud_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	special_tiles = {
		{
			name = "aotearoa_boiling_mud_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
			backface_culling = false,
		},
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "aotearoa:silt",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "aotearoa:boiling_mud_flowing",
	liquid_alternative_source = "aotearoa:boiling_mud_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 1,
	post_effect_color = {a = 200, r = 73, g = 64, b = 55},
	groups = {liquid = 2},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "aotearoa_mud", gain = 0.4},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
})

minetest.register_node("aotearoa:boiling_mud_flowing", {
	description = "Boiling Mud Lava",
	drawtype = "flowingliquid",
	tiles = {"aotearoa_boiling_mud.png"},
	special_tiles = {
		{
			name = "aotearoa_boiling_mud_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "aotearoa_boiling_mud_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "aotearoa:boiling_mud_flowing",
	liquid_alternative_source = "aotearoa:boiling_mud_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	liquid_range = 2,
	damage_per_second = 1,
	post_effect_color = {a = 200, r = 73, g = 64, b = 55},
	groups = {liquid = 2,	not_in_creative_inventory = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "aotearoa_mud", gain = 0.4},
		dug = {name = "aotearoa_mud", gain = 0.4},
	}),
})
]]--
