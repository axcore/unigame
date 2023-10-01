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
	name = "sandy_beach",
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
	y_min = beach_min,
	y_max = beach_max,
	heat_point = sandy_temp,
	humidity_point = sandy_hum,
})

minetest.register_biome({
	name = "shelly_beach",
	--node_dust = "",
	node_top = "aotearoa:seashells",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:river_sand",
	depth_riverbed = 1,
	y_min = beach_min/5,
	y_max = beach_max,
	heat_point = shelly_temp,
	humidity_point = shelly_hum,
})

minetest.register_biome({
	name = "gravel_beach",
	--node_dust = "",
	node_top = "default:gravel",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
  y_min = beach_min,
	y_max = beach_max,
	heat_point = gravel_temp,
	humidity_point = gravel_hum,
})

minetest.register_biome({
	name = "subantarctic_shore",
	--node_dust = "default:snow",
	--node_top = "",
	--depth_top = 1,
	node_filler = "aotearoa:andesite",
	depth_filler = 4,
	node_stone = "aotearoa:granite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
  y_min = beach_min/2,
	y_max = beach_max,
	heat_point = subantartic_temp,
	humidity_point = subantartic_hum,
})

minetest.register_biome({
	name = "volcanic_isle_shore",
	--node_dust = "default:gravel",
	node_top = "default:gravel",
	depth_top = 1,
	node_filler = "default:gravel",
	depth_filler = 1,
	node_stone = "aotearoa:andesite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
  y_min = beach_min,
	y_max = beach_max,
	heat_point = volcanic_isle_temp,
	humidity_point = volcanic_isle_hum,
})

minetest.register_biome({
	name = "volcanic_field",
	--node_dust = "default:gravel",
	node_top = "aotearoa:scoria",
	depth_top = 1,
	node_filler = "aotearoa:scoria",
	depth_filler = 8,
	node_stone = "aotearoa:basalt",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "aotearoa:basalt",
  node_riverbed = "aotearoa:basalt",
  depth_riverbed = 5,
  y_min = beach_min,
	y_max = lowf_max/2,
	heat_point = volcanic_field_temp,
	humidity_point = volcanic_field_hum,
})

minetest.register_biome({
	name = "iron_sand_beach",
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
  depth_riverbed = 1,
  y_min = beach_min,
	y_max = beach_max,
  heat_point = iron_temp,
	humidity_point = iron_hum,
})

minetest.register_biome({
	name = "northern_estuary",
	--node_dust = "",
	node_top = "aotearoa:mud_sinking",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 10,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:mud",
  depth_riverbed = 5,
  y_min = beach_min,
	y_max = beach_max,
	heat_point = estuary_temp,
	humidity_point = estuary_hum,
})

minetest.register_biome({
	name = "southern_estuary",
	--node_dust = "",
	node_top = "aotearoa:mud",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 5,
	node_stone = "aotearoa:grey_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:mud",
  depth_riverbed = 1,
  y_min = beach_min,
	y_max = beach_max,
	heat_point = s_estuary_temp,
	humidity_point = s_estuary_hum,
})
]]--
