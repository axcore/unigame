---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    steampunk
-- Code:    unknown
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("steampunk:grease_source", {
	description = "Grease Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "steampunk_grease_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name = "steampunk_grease_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "steampunk:grease_flowing",
	liquid_alternative_source = "steampunk:grease_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 107, g = 53, b = 18},
	groups = {water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})
minetest.register_craft({
	output = "steampunk:grease_source",
	recipe = {
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
		{"default:coal_lump", "bucket:bucket_water", "default:coal_lump"},
		{"default:coal_lump", "default:dirt",  "default:coal_lump"}
	}
})

minetest.register_node("steampunk:grease_flowing", {
	description = "Flowing Grease",
	drawtype = "flowingliquid",
	tiles = {"steampunk_grease.png"},
	special_tiles = {
		{
			name = "steampunk_grease_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "steampunk_grease_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	alpha = 160,
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
	liquid_alternative_flowing = "steampunk:grease_flowing",
	liquid_alternative_source = "steampunk:grease_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 45, g = 23, b = 7},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,
		not_in_creative_inventory = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})
]]--
