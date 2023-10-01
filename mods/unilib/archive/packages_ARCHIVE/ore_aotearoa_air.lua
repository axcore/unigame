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
minetest.register_ore({
	ore_type        = "blob",
	ore             = "air",
	wherein         = {
		"aotearoa:coquina_limestone",
		"aotearoa:limestone",
		"aotearoa:scoria",
		"aotearoa:basalt",
	 },
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 4,
	y_min           = -31000,
	y_max           = 31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.6,
		spread = {x = 10, y = 10, z = 10},
		seed = -999931,
		octaves = 2,
		persist = 0.9
	},
	--biomes = {},
})
]]--
