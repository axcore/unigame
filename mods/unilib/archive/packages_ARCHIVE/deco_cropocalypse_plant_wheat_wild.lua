---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	name = "cropocalypse:wild_wheat",
	deco_type = "simple",
	place_on = {"group:soil","group:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.1,
		scale = 0.35,
		spread = {x = 10, y = 10, z = 10},
		seed = 6035,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"grassland","savanna","desert","sandstone_desert","cold_desert"},
	y_max = 31000,
	y_min = 1,
	decoration = "cropocalypse:wild_wheat",
})
]]--
