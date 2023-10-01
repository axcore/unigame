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
		deco_type = "simple",
		place_on = {"default:desert_sand",
			"default:sand",},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert", "sandstone_desert",},
		y_min = 2,
		y_max = 31000,
		decoration = "mapgen:small_cactus",
	})

    minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand",
			"default:sand",},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert", "sandstone_desert",},
		y_min = 2,
		y_max = 31000,
		decoration = "mapgen:small_cactus1",
	})
]]--
