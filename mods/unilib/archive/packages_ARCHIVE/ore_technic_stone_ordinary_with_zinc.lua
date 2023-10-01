---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local zinc_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 422,
	octaves = 3,
	persist = 0.7
}
local zinc_threshold = 0.5

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_zinc",
	wherein = "default:stone",
	clust_scarcity = 8*8*8,
	clust_num_ores = 5,
	clust_size = 7,
	y_min = -32,
	y_max = 2,
	noise_params = zinc_params,
	noise_threshold = zinc_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_zinc",
	wherein = "default:stone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 4,
	clust_size = 3,
	y_min = -31000,
	y_max = -32,
	flags = "absheight",
	noise_params = zinc_params,
	noise_threshold = zinc_threshold,
})
]]--
