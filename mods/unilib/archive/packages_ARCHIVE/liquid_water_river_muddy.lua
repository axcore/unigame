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
minetest.register_node("australia:muddy_river_water_source", {
	description = "Muddy river water source",
	drawtype = "liquid",
	tiles = {
		{
			name="aus_muddy_river_water_flowing.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		{
			name="aus_muddy_river_water_flowing.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	alpha = 224,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "australia:muddy_river_water_flowing",
	liquid_alternative_source = "australia:muddy_river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 3,
	post_effect_color = {a = 232, r = 92, g = 80, b = 48},
	groups = {water = 3, liquid = 3, puts_out_fire = 1},
})

minetest.register_node("australia:muddy_river_water_flowing", {
	description = "Flowing muddy river water",
	drawtype = "flowingliquid",
	tiles = {"aus_muddy_river_water_source.png"},
	special_tiles = {
		{
			image="aus_muddy_river_water_flowing.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			image="aus_muddy_river_water_flowing.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	alpha = 224,
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
	liquid_alternative_flowing = "australia:muddy_river_water_flowing",
	liquid_alternative_source = "australia:muddy_river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 3,
	post_effect_color = {a = 232, r = 92, g = 80, b = 48},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,
		not_in_creative_inventory = 1},
})
]]--
