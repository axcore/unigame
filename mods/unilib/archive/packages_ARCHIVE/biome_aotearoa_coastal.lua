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
	name = "pohutukawa_forest",
	--node_dust = "",
	node_top = "default:dirt_with_rainforest_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 2,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:river_sand",
  depth_riverbed = 1,
	y_min = coastf_min,
	y_max = coastf_max,
	heat_point = pohutukawa_temp,
	humidity_point = pohutukawa_hum,
})

minetest.register_biome({
	name = "coastal_scrub",
	--node_dust = "",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 4,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = coastf_min,
	y_max = lowf_max/4,
	heat_point = c_scrub_temp,
	humidity_point = c_scrub_hum,
})

minetest.register_biome({
	name = "muttonbird_scrub",
	--node_dust = "",
	node_top = "default:dirt_with_rainforest_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 2,
	node_stone = "aotearoa:grey_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = coastf_min,
	y_max = coastf_max,
	heat_point = muttonbird_temp,
	humidity_point = muttonbird_hum,
})

minetest.register_biome({
	name = "coastal_tussock",
	--node_dust = "",
	node_top = "default:dirt_with_dry_grass",
	depth_top = 1,
	node_filler = "aotearoa:silt",
	depth_filler = 4,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = coastf_min,
	y_max = coastf_max,
	heat_point = tussock_temp,
	humidity_point = tussock_hum,
})
]]--
