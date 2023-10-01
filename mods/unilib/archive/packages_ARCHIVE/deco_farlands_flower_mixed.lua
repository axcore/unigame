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
	place_on = "mapgen:dirt_with_junglegrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"rainforest",},
	decoration = "flowers_plus:flame_lily",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_swampgrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"swamp",},
	decoration = "flowers_plus:lavender_flower",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "mapgen:dirt_with_leafygrass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"coniferous_forest_tall",},
	decoration = "flowers_plus:purple_allium",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.04,
	biomes = {"deciduous_forest2",},
	decoration = "flowers_plus:lantana",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_snow",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"taiga",},
	decoration = "flowers_plus:frozen_rose",
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"deciduous_forest2",},
	decoration = "flowers_plus:foxglove",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.03,
	biomes = {"deciduous_forest",},
	decoration = "flowers_plus:foxglove_purple",
	height = 1,
})
]]--
