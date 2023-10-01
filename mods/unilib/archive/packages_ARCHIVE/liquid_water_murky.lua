---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_materials:fluid_water_murky_source", {
	description = S("Murky Water Source"),
	drawtype = "liquid",
	tiles = {
		{
			name = "lib_materials_fluid_water_source_animated.png^[colorize:#1F1F00:alpha",
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
			name = "lib_materials_fluid_water_source_animated.png^[colorize:#1F1F00:alpha",
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
	liquid_alternative_flowing = "lib_materials:fluid_water_murky_flowing",
	liquid_alternative_source = "lib_materials:fluid_water_murky_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1, puts_out_fire = 1, },
	sounds = lib_materials.node_sound_water_defaults(),
})
minetest.register_node("lib_materials:fluid_water_murky_flowing", {
	description = S("Murky Flowing Water"),
	drawtype = "flowingliquid",
	tiles = {"lib_materials_fluid_water.png^[colorize:#1F1F00:alpha"},
	special_tiles = {
		{
			name = "lib_materials_fluid_water_flowing_animated.png^[colorize:#1F1F00:alpha",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "lib_materials_fluid_water_flowing_animated.png^[colorize:#1F1F00:alpha",
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
	liquid_alternative_flowing = "lib_materials:fluid_water_murky_flowing",
	liquid_alternative_source = "lib_materials:fluid_water_murky_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1, puts_out_fire = 1, not_in_creative_inventory = 1, },
	sounds = lib_materials.node_sound_water_defaults(),
})
]]--
