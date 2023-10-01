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
moretrees.treelist = {
	{"poplar",       S("Poplar Tree")},
	{"poplar_small", S("Poplar Tree")},
}
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
moretrees.poplar_small_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 4,
	seed_diff = 343,
	min_elevation = 0,
	max_elevation = 50,
	near_nodes = {"default:water_source"},
	near_nodes_size = 10,
	near_nodes_vertical = 5,
	near_nodes_count = 1,
	humidity_min = -0.7,
	humidity_max = -1,
	rarity = 50,
	max_count = 10,
}
]]--

--  moretrees.poplar_model={
--      axiom="TTTaaBCCCCCCCCCCCcccBBB[[f]&&G++f++Gf++Gf++Gf++G--]G[[f]&&G++f++Gf++Gf++Gf++G--]Gff",
--      rules_a="T",
--      rules_b="[[T]&&G++f++ff++ff++ff++f--]G",
--      rules_c="[[T]&&G++f++ff++ff++ff++f--G++[d]G[d]G++G[d]G[d]G[d]G++G[d]G[d]G[d]G++G[d]G[d]G[d]G++G[d]G]G",
--      rules_d="f",
--      trunk="moretrees:poplar_trunk",
--      leaves="moretrees:poplar_leaves",
--      angle=45,
--      iterations=0,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=false,
--  }

--  moretrees.poplar_small_model={
--      axiom="TT[T]BCCCCccBBff",
--      rules_a="T",
--      rules_b="[[f]&&G++f++Gf++Gf++Gf++G--]G",
--      rules_c="[[T]&&G++f++[d]Gf++[d]Gf++[d]Gf++[d]G--]G",
--      rules_d="f",
--      trunk="moretrees:poplar_trunk",
--      leaves="moretrees:poplar_leaves",
--      angle=45,
--      iterations=0,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=false,
--  }

