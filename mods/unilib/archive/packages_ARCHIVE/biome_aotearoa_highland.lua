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
	name = "pahautea_forest",
	node_dust = "default:snow",
	node_top = "aotearoa:dirt_with_moss",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 2,
	node_stone = "aotearoa:andesite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = highf_min,
	y_max = highf_max,
	heat_point = pahautea_temp,
	humidity_point = pahautea_hum,
})

minetest.register_biome({
	name = "rangipo_desert",
	--node_dust = "default:snow",
	node_top = "aotearoa:volcanic_sand",
	depth_top = 6,
	node_filler = "default:clay",
	depth_filler = 2,
	node_stone = "aotearoa:andesite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:volcanic_sand",
  depth_riverbed = 3,
	y_min = highf_min + 12,
	y_max = highf_max,
	heat_point = rangipo_temp,
	humidity_point = rangipo_hum,
})

minetest.register_biome({
	name = "mountain_beech_forest",
	node_dust = "default:snow",
	node_top = "aotearoa:dirt_with_moss",
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
	y_min = highf_min,
	y_max = highf_max,
	heat_point = mt_beech_temp,
	humidity_point = mt_beech_hum,
})

minetest.register_biome({
	name = "mountain_tussock",
	node_dust = "default:snow",
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
	y_min = highf_min,
	y_max = highf_max + 1,
	heat_point = mt_tussock_temp,
	humidity_point = mt_tussock_hum,
})

minetest.register_biome({
	name = "alpine_peat_bog",
	--node_dust = "",
	node_top = "aotearoa:restiad_peat",
	depth_top = 1,
	node_filler = "aotearoa:_peat",
	depth_filler = 6,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:peat",
  depth_riverbed = 3,
	y_min = highf_min,
	y_max = highf_max,
	heat_point = alpine_peat_temp,
	humidity_point = alpine_peat_hum,
})

minetest.register_biome({
	name = "scree",
	--node_dust = "",
	node_top = "default:gravel",
	depth_top = 1,
	node_filler = "aotearoa:silt",
	depth_filler = 1,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = highf_min,
	y_max = alp_max,
	heat_point = scree_temp,
	humidity_point = scree_hum,
})
]]--
