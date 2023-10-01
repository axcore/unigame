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
	name = "kauri_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_dry_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = pohutukawa_temp,
	humidity_point = pohutukawa_hum,
})

minetest.register_biome({
	name = "northern_podocarp_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_dark_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max/2,
	heat_point = npodo_temp,
	humidity_point = npodo_hum,
})

minetest.register_biome({
	name = "tawa_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_dark_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = npodo_temp,
	humidity_point = npodo_hum + 15,
})

minetest.register_biome({
	name = "maire_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_dry_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = npodo_temp,
	humidity_point = npodo_hum - 15,
})

minetest.register_biome({
	name = "southern_podocarp_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_dark_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:grey_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max/2,
	heat_point = spodo_temp,
	humidity_point = spodo_hum,
})

minetest.register_biome({
	name = "hinau_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_dry_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = spodo_temp,
	humidity_point = spodo_hum + 15,
})

minetest.register_biome({
	name = "beech_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_beech_litter",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = spodo_temp,
	humidity_point = spodo_hum - 15,
})

minetest.register_biome({
	name = "fiordland_forest",
	node_dust = "default:snow",
	node_top = "aotearoa:dirt_with_beech_litter",
	depth_top = 1,
	node_filler = "default:gravel",
	depth_filler = 1,
	node_stone = "aotearoa:gneiss",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_min,
	y_max = lowf_max,
	heat_point = fiord_temp,
	humidity_point = fiord_hum,
})

minetest.register_biome({
	name = "kamahi_forest",
	--node_dust = "",
	node_top = "aotearoa:dirt_with_moss",
	depth_top = 1,
	node_filler = "default:clay",
	depth_filler = 3,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 2,
	y_min = lowf_max/2,
	y_max = lowf_max,
	heat_point = kamahi_temp,
	humidity_point = kamahi_hum,
})
]]--
