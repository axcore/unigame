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
	place_on = {"default:dirt_with_grass"},
	sidelen = 6,
	fill_ratio = 0.01,
	biomes = {"grassland", "deciduous_forest", "deciduous_forest2"},
	decoration = "mapgen:wild_oat",
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 6,
	fill_ratio = 0.01,
	biomes = {"savanna"},
	decoration = "mapgen:wild_oat_dry",
	height = 1,
})
]]--
