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
	name = "cold_mantle",
	--node_dust = "",
	node_top = "aotearoa:volcanic_sand",
	depth_top = 10,
	node_filler = "default:gravel",
	depth_filler = 3,
	--node_stone = "default:lava_source",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = -31000,
	y_max = basement_min + 6000,
	heat_point = 50,
	humidity_point = 50,
})

minetest.register_biome({
	name = "wet_mantle",
	--node_dust = "",
	node_top = "aotearoa:boiling_mud_source",
	depth_top = 10,
	node_filler = "aotearoa:boiling_mud_source",
	depth_filler = 3,
	--node_stone = "default:lava_source",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = -31000,
	y_max = basement_min + 3000,
	heat_point = 60,
	humidity_point = 60,
})

minetest.register_biome({
	name = "mantle",
	--node_dust = "default:lava_source",
	node_top = "default:lava_source",
	depth_top = 10,
	node_filler = "default:lava_source",
	depth_filler = 3,
	--node_stone = "default:lava_source",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "default:river_water_source",
	y_min = -31000,
	y_max = basement_min + 1500,
	heat_point = 70,
	humidity_point = 30,
})
]]--
