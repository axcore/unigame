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
	ore             = "aotearoa:grey_sandstone",
	wherein         = {
		"aotearoa:pale_sandstone",
	 },
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 20,
	y_min           = -31000,
	y_max           = 31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0,
		scale = 1,
		spread = {x = 15, y = 15, z = 15},
		seed = -1009674,
		octaves = 2,
		persist = 0.4
	},
})
]]--
