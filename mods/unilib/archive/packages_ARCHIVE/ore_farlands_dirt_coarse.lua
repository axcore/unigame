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
    minetest.register_ore({
		ore_type        = "blob",
		ore             = "mapgen:coarse_dirt",
		wherein         = {"default:stone"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 2,
		y_min           = -31000,
		y_max           = -31,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.4,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 17676,
			octaves = 1,
			persist = 0.0
		},
		biomes = {"taiga", "snowy_grassland", "grassland", "coniferous_forest",
			"deciduous_forest", "savanna", "rainforest"}
	})

    minetest.register_ore({
		ore_type        = "blob",
		ore             = "mapgen:coarse_dirt",
		wherein         = {"mapgen:dirt_with_junglegrass"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_min           = -31000,
		y_max           = 31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "mapgen:coarse_dirt",
		wherein         = {"mapgen:dirt_with_leafygrass"},
		clust_scarcity  = 15 * 15 * 15,
		clust_size      = 3,
		y_min           = -31000,
		y_max           = 31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.55,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
		biomes = {"coniferous_forest_tall",}
	})
]]--
