---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr11
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- Coral reefs
	minetest.register_decoration({
		name = "lib_ecology:corals_1",
		deco_type = "simple",
		place_on = {"lib_materials:sand", "lib_materials:dirt_silt_02", },
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {
			"warm_temperate_ocean",
			"temperate_humid_ocean",
			"temperate_semihumid_ocean",
			"temperate_temperate_ocean",
		},
		y_max = -2,
		y_min = -12,
		flags = "force_placement",
		decoration = {
			"lib_ecology:coral_green_01", "lib_ecology:coral_pink_01",
			"lib_ecology:coral_blue_01", "lib_ecology:coral_brown",
			"lib_ecology:coral_orange_01", "lib_ecology:coral_skeleton",
			"lib_ecology:coral_blue_03", "lib_ecology:coral_red",
			"lib_ecology:coral_orange_03",
		},
	})

	minetest.register_decoration({
		name = "lib_ecology:corals_2",
		deco_type = "simple",
		place_on = {"lib_materials:sand", "lib_materials:dirt_silt_02", },
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -4,
			scale = 4,
			spread = {x = 50, y = 50, z = 50},
			seed = 7013,
			octaves = 3,
			persist = 0.7,
		},
		biomes = {
			"warm_humid_ocean",
			"warm_semihumid_ocean",
		},
		y_max = -4,
		y_min = -14,
		flags = "force_placement",
		decoration = {
			"lib_ecology:coral_green_02", "lib_ecology:coral_pink_02",
			"lib_ecology:coral_blue_02", "lib_ecology:coral_dragon_eye",
			"lib_ecology:coral_orange_02", "lib_ecology:coral_skeleton",
			"lib_ecology:coral_brain", "lib_ecology:coral_staghorn",
			"lib_ecology:coral_pink_03", "lib_ecology:plant_anemone",
		},
	})

-- Kelp
	minetest.register_decoration({
		name = "lib_ecology:kelp",
		deco_type = "simple",
		place_on = {"lib_materials:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"temperate_humid_ocean",
			"temperate_semihumid_ocean",
			"temperate_temperate_ocean",
			"cool_humid_ocean",
			"cool_semihumid_ocean",
			"cool_temperate_ocean"
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {"lib_ecology:plant_kelp_01"},
		param2 = 48,
		param2_max = 96,
	})
    
	minetest.register_decoration({
		name = "lib_ecology:kelp_02_1",
		deco_type = "simple",
		place_on = {"lib_materials:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"temperate_humid_ocean",
			"temperate_semihumid_ocean",
			"temperate_temperate_ocean",
			"cool_humid_ocean",
			"cool_semihumid_ocean",
			"cool_temperate_ocean"
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {"lib_ecology:plant_kelp_02_1"},
		param2 = 48,
		param2_max = 96,
	})
    
	minetest.register_decoration({
		name = "lib_ecology:kelp_02_2",
		deco_type = "simple",
		place_on = {"lib_materials:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"temperate_humid_ocean",
			"temperate_semihumid_ocean",
			"temperate_temperate_ocean",
			"cool_humid_ocean",
			"cool_semihumid_ocean",
			"cool_temperate_ocean"
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {"lib_ecology:plant_kelp_02_2"},
		param2 = 48,
		param2_max = 96,
	})
    
	minetest.register_decoration({
		name = "lib_ecology:seaweed",
		deco_type = "simple",
		place_on = {"lib_materials:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"temperate_humid_ocean",
			"temperate_semihumid_ocean",
			"temperate_temperate_ocean",
			"cool_humid_ocean",
			"cool_semihumid_ocean",
			"cool_temperate_ocean"
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {"lib_ecology:plant_seaweed"},
		param2 = 48,
		param2_max = 96,
	})
    
	minetest.register_decoration({
		name = "lib_ecology:seaweed2",
		deco_type = "simple",
		place_on = {"lib_materials:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"temperate_humid_ocean",
			"temperate_semihumid_ocean",
			"temperate_temperate_ocean",
			"cool_humid_ocean",
			"cool_semihumid_ocean",
			"cool_temperate_ocean"
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {"lib_ecology:plant_seaweed2"},
		param2 = 48,
		param2_max = 96,
	})
    
	minetest.register_decoration({
		name = "lib_ecology:seaweed3",
		deco_type = "simple",
		place_on = {"lib_materials:sand"},
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"temperate_humid_ocean",
			"temperate_semihumid_ocean",
			"temperate_temperate_ocean",
			"cool_humid_ocean",
			"cool_semihumid_ocean",
			"cool_temperate_ocean"
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {"lib_ecology:plant_seaweed3"},
		param2 = 48,
		param2_max = 96,
	})

-- Sea Grass
	minetest.register_decoration({
		name = "lib_ecology:sea_grass",
		deco_type = "simple",
		place_on = {"lib_materials:sand", },
		place_offset_y = -1,
		sidelen = 16,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"hot_semiarid_ocean",
			"warm_semiarid_ocean",
			"temperate_semiarid_ocean",
			"cool_semiarid_ocean",
		},
		y_max = -5,
		y_min = -10,
		flags = "force_placement",
		decoration = {
			"lib_ecology:grass_sea_1", "lib_ecology:grass_sea_2",
			"lib_ecology:grass_sea_3",
		},
		param2 = 48,
		param2_max = 96,
	})

	minetest.register_decoration({
		name = "lib_ecology:reedmace_water",
		deco_type = "simple",
		place_on = {"lib_materials:dirt_mud_01"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"lib_ecology_deciduous_forest_swamp",
			"lib_materials_subtropical_rainforest_swamp",
			"lib_materials_temperate_rainforest_swamp"
		},
		y_max = 0,
		y_min = -3,
		flags = "force_placement",
		decoration = {"lib_ecology:plant_reedmace_water", "lib_ecology:plant_reedmace_sapling_water"},
		param2 = 48,
		param2_max = 96,
	})

	minetest.register_decoration({
		name = "lib_ecology:mangroves",
		deco_type = "simple",
		place_on = {"lib_materials:dirt_silt_01"},
		place_offset_y = -1,
		sidelen = 4,
		noise_params = {
			offset = -0.004,
			scale = 0.1,
			spread = {x = 200, y = 200, z = 200},
			seed = 87112,
			octaves = 3,
			persist = 0.7
		},
		biomes = {
			"hot_humid_beach",
			"hot_semihumid_beach",
			"warm_humid_beach"
		},
		y_max = 0,
		y_min = -3,
		flags = "force_placement",
		decoration = {"lib_ecology:tree_mangrove_root"},
		param2 = 48,
		param2_max = 96,
	})
]]--
