---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local mineral_scale = 0.03
local mineral_spread = {x = 40, y = 40, z = 40}
local mineral_oct = 3
local mineral_persist = 0.8
local deep_scatter = -256

minetest.register_ore({
	ore_type        = "blob",
	ore             = "aotearoa:limonite",
	wherein         = {
		"aotearoa:conglomerate",
		"aotearoa:siltstone",
		"aotearoa:claystone",
	 },
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_min           = -31000,
	y_max           = 31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = mineral_scale,
		spread = mineral_spread,
		seed = 1184053,
		octaves = mineral_oct,
		persist = mineral_persist
	},
	--biomes = {},
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "aotearoa:limonite",
	wherein         = {
		"aotearoa:pale_sandstone",
		"aotearoa:grey_sandstone",
		"basalt",
	 },
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 2,
	y_min           = -31000,
	y_max           = 31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = mineral_scale,
		spread = mineral_spread,
		seed = 1184053,
		octaves = mineral_oct,
		persist = mineral_persist
	},
	--biomes = {},
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "aotearoa:limonite",
	wherein         = {
		"aotearoa:conglomerate",
		"aotearoa:siltstone",
		"aotearoa:claystone",
		"aotearoa:pale_sandstone",
		"aotearoa:grey_sandstone",
		"basalt",
	 },
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = deep_scatter,
})
]]--
