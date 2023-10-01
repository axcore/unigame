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
		name = "xocean:horn",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.0001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 20,
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
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/horn.mts",
		param2 = 48,
		param2_max = 96,
	})

minetest.register_decoration({
		name = "xocean:horn2",
		deco_type = "schematic",
		place_on = {"default:sand"},
		place_offset_y = -1,
		sidelen = 2,
		noise_params = {
			offset = 0.0001,
			scale = 0.001,
			spread = {x = 100000, y = 100000, z = 100000},
			seed = 87112,
			octaves = 28,
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
		y_max = -6,
		y_min = -16,
		flags = "force_placement",
		schematic = minetest.get_modpath("xocean") .. "/schems/horn2.mts",
		param2 = 48,
		param2_max = 96,
	})
]]--
