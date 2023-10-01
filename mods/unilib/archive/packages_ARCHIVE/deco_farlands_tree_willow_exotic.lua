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
		place_on = {"mapgen:dirt_with_swampgrass"},
		sidelen = 16,
		noise_params = {
			offset = 0.0,
			scale = -0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"swamp"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/willow.mts",
		flags = "place_center_x, place_center_z",
	})

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"mapgen:dirt_with_swampgrass"},
		sidelen = 16,
		noise_params = {
			offset = 0.01,
			scale = 0.001,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"swamp"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("mapgen") .. "/schematics/willow2.mts",
		flags = "place_center_x, place_center_z",
	})
]]--
