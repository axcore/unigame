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
	name = "greywacke_basement",
	--node_dust = "",
	node_top = "aotearoa:greywacke",
	depth_top = 5,
	node_filler = "aotearoa:greywacke",
	depth_filler = 5,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = basement_min,
	y_max = basement_max,
	heat_point = gw_heat,
	humidity_point = gw_hum,
})

minetest.register_biome({
	name = "schist_basement",
	--node_dust = "",
	node_top = "aotearoa:schist",
	depth_top = 5,
	node_filler = "aotearoa:schist",
	depth_filler = 5,
	node_stone = "aotearoa:schist",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = basement_min,
	y_max = basement_max,
	heat_point = sch_heat,
	humidity_point = sch_hum,
})

minetest.register_biome({
	name = "gneiss_basement",
	--node_dust = "",
	node_top = "aotearoa:gneiss",
	depth_top = 5,
	node_filler = "aotearoa:gneiss",
	depth_filler = 5,
	node_stone = "aotearoa:gneiss",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = basement_min,
	y_max = basement_max,
	heat_point = gn_heat,
	humidity_point = gn_hum,
})

minetest.register_biome({
	name = "granite_basement",
	--node_dust = "",
	node_top = "aotearoa:granite",
	depth_top = 5,
	node_filler = "aotearoa:granite",
	depth_filler = 5,
	node_stone = "aotearoa:granite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = basement_min,
	y_max = basement_max,
	heat_point = gr_heat,
	humidity_point = gr_hum,
})
]]--
