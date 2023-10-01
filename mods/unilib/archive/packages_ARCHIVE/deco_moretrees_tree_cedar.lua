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
moretrees.cedar_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 336,
	min_elevation = 0,  --Added to solve an issue where cedar trees would sometimes spawn deep underground
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 5,
	rarity = 50,
	max_count = 10,
}
]]--
