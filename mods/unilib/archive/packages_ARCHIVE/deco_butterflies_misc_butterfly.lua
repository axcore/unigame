---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    butterflies
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_decoration({
	name = "butterflies:butterfly",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	place_offset_y = 2,
	sidelen = 80,
	fill_ratio = 0.005,
	biomes = {"grassland", "deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	decoration = {
		"butterflies:butterfly_white",
		"butterflies:butterfly_red",
		"butterflies:butterfly_violet"
	},
	spawn_by = "group:flower",
	num_spawn_by = 1
})
]]--
