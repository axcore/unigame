---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_biome({
	name = "pohutukawa_dunes",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:river_sand",
  depth_riverbed = 2,
	y_min = dune_min,
	y_max = dune_max,
	heat_point = pohutukawa_temp,
	humidity_point = pohutukawa_hum,
})

minetest.register_biome({
	name = "sand_dunes",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:river_sand",
  depth_riverbed = 2,
  y_min = dune_min,
	y_max = dune_max,
  heat_point = sandy_temp,
	humidity_point = sandy_hum,
})

minetest.register_biome({
	name = "iron_sand_dunes",
	--node_dust = "",
	node_top = "aotearoa:iron_sand",
	depth_top = 3,
	node_filler = "aotearoa:iron_sand",
	depth_filler = 3,
	node_stone = "aotearoa:grey_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:river_sand",
  depth_riverbed = 2,
  y_min = dune_min,
	y_max = dune_max,
	heat_point = iron_temp,
	humidity_point = iron_hum,
})

minetest.register_biome({
	name = "salt_marsh",
	--node_dust = "",
	node_top = "aotearoa:mud",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:mud",
  depth_riverbed = 2,
  y_min = dune_min,
	y_max = dune_max,
	heat_point = s_marsh_temp,
	humidity_point = s_marsh_hum,
})

minetest.register_biome({
	name = "gravel_dunes",
	--node_dust = "",
	node_top = "default:gravel",
	depth_top = 1,
	node_filler = "default:gravel",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
  y_min = dune_min,
	y_max = dune_max,
  heat_point = gravel_temp,
	humidity_point = gravel_hum,
})

minetest.register_biome({
	name = "subantarctic_coast",
	node_dust = "default:snow",
	node_top = "aotearoa:dirt_with_moss",
	depth_top = 1,
	node_filler = "aotearoa:andesite",
	depth_filler = 4,
	node_stone = "aotearoa:granite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
  y_min = dune_min,
	y_max = coastf_max,
  heat_point = subantartic_temp,
	humidity_point = subantartic_hum,
})

minetest.register_biome({
	name = "white_island",
	--node_dust = "",
	node_top = "aotearoa:volcanic_sand",
	depth_top = 1,
	node_filler = "aotearoa:volcanic_sand",
	depth_filler = 5,
	node_stone = "aotearoa:andesite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
  y_min = dune_min,
	y_max = lowf_max/2,
  heat_point = volcanic_isle_temp,
	humidity_point = volcanic_isle_hum,
})
]]--
