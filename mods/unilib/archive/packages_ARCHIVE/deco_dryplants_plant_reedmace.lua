---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    plantlife/dryplants
-- Code:    LGPL v3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- near water or swamp
biome_lib.register_on_generate({
    surface = {
		"default:dirt_with_grass",
		"default:desert_sand",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = REEDMACE_NEAR_WATER_PER_MAPBLOCK,
    rarity = 101 - REEDMACE_NEAR_WATER_RARITY,
	--rarity = 60,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:water_source","sumpf:dirtywater_source","sumpf:sumpf"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace
)
-- in water
biome_lib.register_on_generate({
    surface = {
		"default:dirt",
		"default:dirt_with_grass",
		--"default:desert_sand",
		--"stoneage:grass_with_silex",
		"stoneage:sand_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = REEDMACE_IN_WATER_PER_MAPBLOCK,
	rarity = 101 - REEDMACE_IN_WATER_RARITY,
    --rarity = 35,
    min_elevation = 0, -- a bit below sea level
	max_elevation = 0, -- ""
	near_nodes = {"default:water_source","sumpf:dirtywater_source"},
	near_nodes_size = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace_water
)
-- for oases & tropical beaches & tropical swamps
biome_lib.register_on_generate({
    surface = {
		"default:sand",
		"sumpf:sumpf"
	},
    max_count = REEDMACE_FOR_OASES_PER_MAPBLOCK,
    rarity = 101 - REEDMACE_FOR_OASES_RARITY,
	--rarity = 10,
    neighbors = {"default:water_source","sumpf:dirtywater_source","sumpf:sumpf"},
	ncount = 1,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:desert_sand","sumpf:sumpf"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace
)
]]--
