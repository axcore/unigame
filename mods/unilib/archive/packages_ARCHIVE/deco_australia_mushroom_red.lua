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
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 200, y = 200, z = 200},
		seed = 56,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"tasmania"},
	y_min = 7,
	y_max = 31000,
	decoration = "flowers:mushroom_red",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 200, y = 200, z = 200},
		seed = 56,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"victorian_forests"},
	y_min = 36,
	y_max = 180,
	decoration = "flowers:mushroom_red",
})
]]--
