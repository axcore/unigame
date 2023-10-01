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
	{"date_palm",    S("Date Palm Tree"), "date_palm_fruit_trunk", S("Date Palm Tree"), {0, 0, 0, 0, 0, 0}, 0.0 },
}
moretrees.date_palm_biome = {
	surface = "default:desert_sand",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 339,
	min_elevation = -1,
	max_elevation = 10,
	near_nodes = {"default:water_source"},
	near_nodes_size = 20,
	near_nodes_count = 100,
	near_nodes_vertical = 20,
	temp_min = -0.20,
	humidity_max = 0.20,
	rarity = 10,
	max_count = 30,
}
moretrees.date_palm_biome_2 = {
	surface = "default:desert_sand",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 340,
	min_elevation = 11,
	max_elevation = 30,
	near_nodes = {"default:water_source"},
	near_nodes_size = 1,
	near_nodes_count = 1,
	near_nodes_vertical = 30,
	temp_min = -0.20,
	humidity_max = 0.20,
	rarity = 10,
	max_count = 30,
}
]]--

--  moretrees.date_palm_model={
--      axiom="TTTTddddddddddccccccccccRT[TTT]"..
--          "ccccc[&&a]ccccc[&&a]ccccc[&&a]ccccc[&&a]ccccc[&&a]ccccc[&&a]"..
--          "GGccccc[&a]ccccc[&a]ccccc[&a]ccccc[&a]ccccc[&a]ccccc[&a]"..
--          "GGccccc[a]ccccc[a]ccccc[a]ccccc[a]ccccc[a]ccccc[a]",
--      rules_a="Gffb&bbb[++f--&ffff&ff][--f++&ffff&ff]&ff&ff&bb&bb&bb",
--      rules_b="f",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:date_palm_trunk",
--      leaves="moretrees:date_palm_leaves",
--      angle=18,
--      iterations=1,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=false,
--      fruit="moretrees:date_palm_fruit_trunk",
--      fruit_chance=0
--  }
