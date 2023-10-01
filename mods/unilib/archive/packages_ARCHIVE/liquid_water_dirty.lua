---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mapgen:dirty_water_source", {
	description = "Dirty Water Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "mapgen_dirty_water_source_animated.png^[opacity:200",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	-- special_tiles = {
	-- 	{
	-- 		name = "mapgen_dirty_water_source_animated.png",
	-- 		animation = {
	-- 			type = "vertical_frames",
	-- 			aspect_w = 16,
	-- 			aspect_h = 16,
	-- 			length = 2.0,
	-- 		},
	-- 		backface_culling = false,
	-- 	},
	-- },
	-- alpha = 160,
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "mapgen:dirty_water_flowing",
	liquid_alternative_source = "mapgen:dirty_water_source",
	liquid_viscosity = 2,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("mapgen:dirty_water_flowing", {
	description = "Flowing Dirty Water",
	drawtype = "flowingliquid",
	-- tiles = {"default_river_water.png^[colorize:green:100"},
	special_tiles = {
		{
			name = "mapgen_dirty_water_flowing_animated.png^[opacity:200",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "mapgen_dirty_water_flowing_animated.png^[opacity:200",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	-- alpha = 160,
	use_texture_alpha = "blend",
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
	liquid_alternative_flowing = "mapgen:dirty_water_flowing",
	liquid_alternative_source = "mapgen:dirty_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,
		not_in_creative_inventory = 1, cools_lava = 1},
	sounds = default.node_sound_water_defaults(),
})
]]--
