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
		--"default:desert_sand",
		--"default:sand",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = JUNCUS_NEAR_WATER_PER_MAPBLOCK,
    rarity = 101 - JUNCUS_NEAR_WATER_RARITY,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:water_source","sumpf:dirtywater_source","sumpf:sumpf"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_juncus
)
-- at dunes/beach
biome_lib.register_on_generate({
    surface = {
		--"default:dirt_with_grass",
		--"default:desert_sand",
		"default:sand",
		--"stoneage:grass_with_silex",
		--"sumpf:peat",
		--"sumpf:sumpf"
	},
    max_count = JUNCUS_AT_BEACH_PER_MAPBLOCK,
    rarity = 101 - JUNCUS_AT_BEACH_RARITY,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:dirt_with_grass"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_juncus
)
]]--
