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
-- Poplar requires a lot of water.
moretrees.poplar_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 6,
	seed_diff = 341,
	min_elevation = 0,
	max_elevation = 50,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_vertical = 5,
	near_nodes_count = 1,
	humidity_min = -0.7,
	humidity_max = -1,
	rarity = 50,
	max_count = 15,
}
]]--
