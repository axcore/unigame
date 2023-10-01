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
local lead_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 423,
	octaves = 3,
	persist = 0.7
}
local lead_threshold = 0.3

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_lead",
	wherein = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size = 3,
	y_min = -16,
	y_max = 16,
	noise_params = lead_params,
	noise_threshold = lead_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_lead",
	wherein = "default:stone",
	clust_scarcity = 8*8*8,
	clust_num_ores = 5,
	clust_size = 3,
	y_min = -128,
	y_max = -16,
	noise_params = lead_params,
	noise_threshold = lead_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_lead",
	wherein = "default:stone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 5,
	clust_size = 3,
	y_min = -31000,
	y_max = -128,
	flags = "absheight",
	noise_params = lead_params,
	noise_threshold = lead_threshold,
})
]]--
