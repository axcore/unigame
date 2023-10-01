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
  	{"apple_tree",   S("Apple Tree")},
}
moretrees.apple_tree_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 331,
	min_elevation = 1,
	max_elevation = 10,
	temp_min = 0.1,
	temp_max = -0.15,
	rarity = 75,
	max_count = 5,
}
]]--

--  moretrees.apple_tree_model={
--      axiom="FFFFFAFFBF",
--      rules_a="[&&&FFFFF&&FFFF][&&&++++FFFFF&&FFFF][&&&----FFFFF&&FFFF]",
--      rules_b="[&&&++FFFFF&&FFFF][&&&--FFFFF&&FFFF][&&&------FFFFF&&FFFF]",
--      trunk="moretrees:apple_tree_trunk",
--      leaves="moretrees:apple_tree_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=true,
--      fruit="default:apple",
--      fruit_chance=15,
--  }
