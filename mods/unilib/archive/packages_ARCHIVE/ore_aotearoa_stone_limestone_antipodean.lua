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
	ore             = "aotearoa:limestone",
	wherein         = {
		"aotearoa:pale_sandstone",
		"aotearoa:grey_sandstone",
	 },
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 25,
	y_min           = -31000,
	y_max           = 31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0,
		scale = 1,
		spread = {x = 15, y = 15, z = 15},
		seed = -2018,
		octaves = 1,
		persist = 0.0
	},
})
]]--
