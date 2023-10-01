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
	name = "kermadec_ocean",
	--node_dust = "",
	node_top = "default:gravel",
	depth_top = 1,
	node_filler = "aotearoa:andesite",
	depth_filler = 2,
	node_stone = "aotearoa:andesite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = kerm_o_heat,
	humidity_point = kerm_o_hum,
})

minetest.register_biome({
	name = "north_eastern_ocean",
	--node_dust = "",
	node_top = "aotearoa:mud_sinking",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 6,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = n_east_o_heat,
	humidity_point = n_east_o_hum,
})

minetest.register_biome({
	name = "west_coast_north_ocean",
	--node_dust = "",
	node_top = "aotearoa:iron_sand",
	depth_top = 1,
	node_filler = "aotearoa:iron_sand",
	depth_filler = 3,
	node_stone = "aotearoa:grey_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = wc_nth_o_heat,
	humidity_point = wc_nth_o_hum,
})

minetest.register_biome({
	name = "east_coast_north ocean",
	--node_dust = "",
	node_top = "aotearoa:mud_sinking",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 4,
	node_stone = "aotearoa:pale_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = ec_nth_o_heat,
	humidity_point = ec_nth_o_hum,
})

minetest.register_biome({
	name = "north_cook_straight",
	--node_dust = "",
	node_top = "aotearoa:mud",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 3,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = n_cook_o_heat,
	humidity_point = n_cook_o_hum,
})

minetest.register_biome({
	name = "south_cook_straight",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 3,
	node_stone = "aotearoa:schist",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = s_cook_o_heat,
	humidity_point = s_cook_o_hum,
})

minetest.register_biome({
	name = "west_coast_south_ocean",
	--node_dust = "",
	node_top = "aotearoa:mud",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 3,
	node_stone = "aotearoa:grey_sandstone",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = wc_sth_o_heat,
	humidity_point = wc_sth_o_hum,
})

minetest.register_biome({
	name = "east_coast_south_ocean",
	--node_dust = "",
	node_top = "aotearoa:mud_sinking",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 6,
	node_stone = "aotearoa:greywacke",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = ec_sth_o_heat,
	humidity_point = ec_sth_o_hum,
})

minetest.register_biome({
	name = "fiordland_ocean",
	--node_dust = "",
	node_top = "aotearoa:mud",
	depth_top = 1,
	node_filler = "aotearoa:mud",
	depth_filler = 2,
	node_stone = "aotearoa:gneiss",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = fiord_o_heat,
	humidity_point = fiord_o_hum,
})

minetest.register_biome({
	name = "southern_ocean",
	--node_dust = "",
	node_top = "default:gravel",
	depth_top = 1,
	node_filler = "default:gravel",
	depth_filler = 1,
	node_stone = "aotearoa:schist",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = sth_o_heat,
	humidity_point = sth_o_hum,
})

minetest.register_biome({
	name = "subantarctic_ocean",
	--node_dust = "",
	node_top = "default:gravel",
	depth_top = 1,
	node_filler = "default:gravel",
	depth_filler = 1,
	node_stone = "aotearoa:granite",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = ocean_min,
	y_max = ocean_max,
	heat_point = subant_o_heat,
	humidity_point = subant_o_hum,
})
]]--
