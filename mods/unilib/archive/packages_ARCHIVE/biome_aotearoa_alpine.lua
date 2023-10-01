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
	name = "fellfield",
	node_dust = "default:snow",
	--node_top = "",
	--depth_top = 1,
	node_filler = "aotearoa:schist",
	depth_filler = 4,
	node_stone = "aotearoa:schist",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = alp_min,
	y_max = alp_max,
	heat_point = 50,
	humidity_point = 50,
})

minetest.register_biome({
	name = "alpine_snow",
	node_dust = "default:snow",
	node_top = "default:snowblock",
	depth_top = 5,
	node_filler = "default:ice",
	depth_filler = 1,
	node_stone = "aotearoa:schist",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:gravel_with_algae",
  depth_riverbed = 1,
	y_min = high_alp_min,
	y_max = high_alp_max,
	heat_point = 50,
	humidity_point = 50,
})

minetest.register_biome({
	name = "glacier",
	node_dust = "default:snow",
	node_top = "default:ice",
	depth_top = 10,
	node_filler = "default:ice",
	depth_filler = 1,
	node_stone = "aotearoa:schist",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "default:ice",
  depth_riverbed = 1,
	y_min = alp_min + 4,
	y_max = high_alp_max,
	heat_point = 0,
	humidity_point = 100,
})

minetest.register_biome({
	name = "volcano",
	node_dust = "default:snow",
	node_top = "aotearoa:volcanic_sand",
	depth_top = 2,
	node_filler = "default:gravel",
	depth_filler = 5,
	node_stone = "aotearoa:andesite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
  node_river_water = "default:river_water_source",
  node_riverbed = "aotearoa:volcanic_sand",
  depth_riverbed = 3,
	y_min = alp_min,
	y_max = high_alp_max,
	heat_point = 100,
	humidity_point = 0,
})
]]--
