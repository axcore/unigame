---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("butterflies") then

	minetest.register_decoration({
		name = "butterflies:butterfly",
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "ethereal:prairie_dirt"},
		place_offset_y = 2,
		sidelen = 80,
		fill_ratio = 0.005,
		biomes = {"deciduous_forest", "grassytwo", "prairie", "jumble"},
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
end
]]--
