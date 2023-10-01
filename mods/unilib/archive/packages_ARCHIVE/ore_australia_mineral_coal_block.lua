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
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:coalblock",
	wherein        = "default:stone",
	clust_scarcity = 48 * 48 * 48,
	clust_num_ores = 8,
	clust_size     = 3,
	biomes         = {"eastern_coasts"},
	y_min          = -64,
	y_max          = 35,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:coalblock",
	wherein        = "default:stone",
	clust_scarcity = 48 * 48 * 48,
	clust_num_ores = 8,
	clust_size     = 3,
	biomes         = {"great_dividing_range"},
	y_min          = -64,
	y_max          = 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:coalblock",
	wherein        = "default:stone",
	clust_scarcity = 48 * 48 * 48,
	clust_num_ores = 8,
	clust_size     = 3,
	biomes         = {"victorian_forests"},
	y_min          = -64,
	y_max          = 64,
})
]]--
