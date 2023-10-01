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
	name = "kahikatea_swamp",
	--node_dust = "",
	node_top = "aotearoa:forest_peat",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 6,
	node_stone = "aotearoa:grey_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:river_sand",
  depth_riverbed = 1,
	y_min = coastf_min + 2,
	y_max = lowf_max/3,
	heat_point = kahi_swamp_temp,
	humidity_point = kahi_swamp_hum,
})

minetest.register_biome({
	name = "raupo_swamp",
	--node_dust = "",
	node_top = "aotearoa:mud_sinking",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:mud",
  depth_riverbed = 1,
	y_min = coastf_min + 2,
	y_max = lowf_max/2,
	heat_point = raupo_swamp_temp,
	humidity_point = raupo_swamp_hum,
})

minetest.register_biome({
	name = "gumland",
	--node_dust = "",
	node_top = "aotearoa:gumland_soil",
	depth_top = 1,
	node_filler = "aotearoa:gumland_hardpan",
	depth_filler = 4,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:silt",
  depth_riverbed = 3,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = gumland_temp,
	humidity_point = gumland_hum,
})

minetest.register_biome({
	name = "fen",
	--node_dust = "",
	node_top = "aotearoa:restiad_peat",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:mud",
  depth_riverbed = 1,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = fen_temp,
	humidity_point = fen_hum,
})

minetest.register_biome({
	name = "peat_bog",
	--node_dust = "",
	node_top = "aotearoa:restiad_peat",
	depth_top = 1,
	node_filler = "aotearoa:peat",
	depth_filler = 15,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:peat",
  depth_riverbed = 4,
	y_min = lowf_min,
	y_max = lowf_max/2,
	heat_point = peat_temp,
	humidity_point = peat_hum,
})
]]--
