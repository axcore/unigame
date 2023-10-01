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
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass", "mapgen:dirt_with_leafygrass", "mapgen:dirt_with_swampgrass",
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"grassland", "deciduous_forest", "coniferous_forest_tall", "swamp"},
	decoration = "mapgen:tallgrass",
	height = 1,
})
]]--
