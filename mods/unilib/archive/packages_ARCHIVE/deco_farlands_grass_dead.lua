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
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna"},
	decoration = "mapgen:dead_grass_1",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna"},
	decoration = "mapgen:dead_grass_2",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass", "default:desert_sand"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna", "desert"},
	decoration = "mapgen:dead_grass_3",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass", "default:desert_sand"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna", "desert"},
	decoration = "mapgen:dead_grass_4",
	height = 1,
})
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_dry_grass", "default:desert_sand"},
	sidelen = 6,
	fill_ratio = 0.002,
	biomes = {"savanna", "desert"},
	decoration = "mapgen:dead_grass_5",
	height = 1,
})
]]--
