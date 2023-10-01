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
add_simple_flower("lavender_flower", "Lavender", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {color_purple=1, flammable=1})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_swampgrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"swamp",},
	decoration = "flowers_plus:lavender_flower",
	height = 1,
})
]]--
