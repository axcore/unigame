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
	name = "broadleaf_scrub",
	--node_dust = "",
	node_top = "default:dirt_with_rainforest_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 4,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = (lowf_max/4) -4,
	y_max = lowf_max/2,
	heat_point = bl_scrub_temp,
	humidity_point = bl_scrub_hum,
})

minetest.register_biome({
	name = "geothermal_scrub",
	--node_dust = "",
	node_top = "default:dirt_with_rainforest_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 4,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max/3,
	heat_point = geo_scrub_temp,
	humidity_point = geo_scrub_hum,
})

minetest.register_biome({
	name = "manuka_scrub",
	--node_dust = "",
	node_top = "default:dirt_with_rainforest_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 4,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = ma_scrub_temp,
	humidity_point = ma_scrub_hum,
})

minetest.register_biome({
	name = "matagouri_scrub",
	--node_dust = "",
	node_top = "default:dirt_with_dry_grass",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 2,
	node_stone = "aotearoa:schist",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = tussock_temp,
	humidity_point = tussock_hum,
})
]]--
