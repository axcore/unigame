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
minetest.register_decoration({
		name = "xocean:bubble_plant",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:bubble",
		param2 = 48,
		param2_max = 96,
	})
    
minetest.register_decoration({
		name = "xocean:bubble_plant_skeleton",
		deco_type = "simple",
		place_on = {"xocean:brain_block","xocean:tube_block","default:coral_orange","default:coral_brown","xocean:bubble_block"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 1.0,
			spread = {x = 20, y = 20, z = 20},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"taiga_ocean",
			"snowy_grassland_ocean",
			"grassland_ocean",
			"coniferous_forest_ocean",
			"deciduous_forest_ocean",
			"sandstone_desert_ocean",
			"cold_desert_ocean"},
		y_max = -5,
		y_min = -50,
		flags = "force_placement",
		decoration = "xocean:skeleton_bubble",
		param2 = 48,
		param2_max = 96,
	})
]]--
