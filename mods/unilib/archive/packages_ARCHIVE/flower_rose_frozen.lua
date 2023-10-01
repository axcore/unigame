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
add_simple_flower("frozen_rose", "Frozen Rose", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_blue=1, flammable=0})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"taiga",},
	decoration = "flowers_plus:frozen_rose",
	height = 1,
})
]]--
