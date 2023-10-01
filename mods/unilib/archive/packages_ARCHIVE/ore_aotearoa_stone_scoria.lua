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
	ore             = "aotearoa:scoria",
	wherein         = {
		"aotearoa:basalt",
		"aotearoa:andesite",
	 },
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 3,
	y_min           = -31000,
	y_max           = 31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.01,
		spread = {x = 5, y = 5, z = 5},
		seed = 7701112,
		octaves = 1,
		persist = 0.2
	},
})
]]--
