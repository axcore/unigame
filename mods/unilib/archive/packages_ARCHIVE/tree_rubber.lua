---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
--
-- From:    technic/technic_worldgen
-- Code:    LGPL 2.0
-- Media:   unknown
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
moretrees.treelist = {
	{"rubber_tree",  S("Rubber Tree")},
}
moretrees.rubber_tree_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 338,
	min_elevation = -5,
	max_elevation = 5,
	near_nodes = {"default:water_source"},
	near_nodes_size = 15,
	near_nodes_count = 10,
	temp_min = -0.15,
	rarity = 75,
	max_count = 10,
}

--  moretrees.rubber_tree_model={
--      axiom="FFFFA",
--      rules_a="[&FFBFA]////[&BFFFA]////[&FBFFA]",
--      rules_b="[&FFA]////[&FFA]////[&FFA]",
--      trunk="moretrees:rubber_tree_trunk",
--      leaves="moretrees:rubber_tree_leaves",
--      angle=35,
--      iterations=3,
--      random_level=1,
--      trunk_type="double",
--      thin_branches=true
--  }
]]--

