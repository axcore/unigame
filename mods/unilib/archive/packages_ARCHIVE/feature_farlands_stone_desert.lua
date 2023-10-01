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
    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.0005,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"desert",},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/rocks/desert_rock1.mts",
		flags = "place_center_x, place_center_z",
	})
    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.0005,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"desert",},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/rocks/desert_rock2.mts",
		flags = "place_center_x, place_center_z",
	})
    minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.0005,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"desert",},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/rocks/desert_rock3.mts",
		flags = "place_center_x, place_center_z",
	})
]]--
