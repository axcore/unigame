---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
moretrees.fir_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 359,
	min_elevation = 25,
	temp_min = 0.9,
	temp_max = 0.3,
	rarity = 50,
	max_count = 10,
}

moretrees.fir_biome_snow = {
	surface = {"snow:dirt_with_snow", "snow:snow"},
	below_nodes = {"default:dirt", "default:dirt_with_grass", "snow:dirt_with_snow"},
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 359,
	rarity = 50,
	max_count = 10,
	check_air = false,
	delete_above = true,
	spawn_replace_node = true
}
]]--
