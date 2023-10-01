---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
add_simple_flower("lantana", "Lantana", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_purple=1, flammable=1})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.04,
	biomes = {"deciduous_forest2",},
	decoration = "flowers_plus:lantana",
	height = 1,
})
]]--
