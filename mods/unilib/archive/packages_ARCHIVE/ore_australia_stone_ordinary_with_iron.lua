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
	ore_type        = "blob",
	ore             = "air",
	wherein         = {"default:stone"},
	clust_scarcity  = 24 * 24 * 24,
	clust_size      = 8,
	biomes          = {"pilbara"},
	y_min           = -64,
	y_max           = 35,
	noise_threshold = 1,
	noise_params    = {
		offset = 0,
		scale = 3,
		spread = {x = 16, y = 16, z = 16},
		seed = 895,
		octaves = 3,
		persist = 0.6
	},
})
]]--
