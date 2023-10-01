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
	{"oak",          S("Oak Tree"),       "acorn",                 S("Acorn"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
}
moretrees.oak_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 15,
	seed_diff = 332,
	min_elevation = 0,
	max_elevation = 10,
	temp_min = 0.4,
	temp_max = 0.2,
	rarity = 50,
	max_count = 5,
}
]]--

--  moretrees.oak_model={
--      axiom="FFFFFFA",
--      rules_a="[&FFBFA]////[&BFFFA]////[&FBFFA]",
--      rules_b="[&FFFA]////[&FFFA]////[&FFFA]",
--      trunk="moretrees:oak_trunk",
--      leaves="moretrees:oak_leaves",
--      angle=30,
--      iterations=5,
--      random_level=2,
--      trunk_type="crossed",
--      thin_branches=false,
--      fruit="moretrees:acorn",
--      fruit_chance=3,
--  }
