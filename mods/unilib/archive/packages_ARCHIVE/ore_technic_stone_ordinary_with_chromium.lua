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
local chromium_params = {
	offset = 0,
	scale = 1,
	spread = {x = 100, y = 100, z = 100},
	seed = 421,
	octaves = 3,
	persist = 0.7
}
local chromium_threshold = 0.55

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_chromium",
	wherein = "default:stone",
	clust_scarcity = 8*8*8,
	clust_num_ores = 2,
	clust_size = 3,
	y_min = -200,
	y_max = -100,
	noise_params = chromium_params,
	noise_threshold = chromium_threshold,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "technic:mineral_chromium",
	wherein = "default:stone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 2,
	clust_size = 3,
	y_min = -31000,
	y_max = -200,
	flags = "absheight",
	noise_params = chromium_params,
	noise_threshold = chromium_threshold,
})
]]--
