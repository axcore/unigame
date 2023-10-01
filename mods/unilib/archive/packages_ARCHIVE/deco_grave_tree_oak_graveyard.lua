---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grave
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	name = "grave:grave_oak_tree",
	deco_type = "schematic",
	place_on = {"grave:grave_dirt_with_grave_grass"},
	sidelen = 80,
	noise_params = {
		offset = 0.010,
		scale = -0.048,
		spread = {x = 50, y = 50, z = 50},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("grave") .. "/schems/grave_grave_oak.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random"
})
]]--
