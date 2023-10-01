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
	{"beech",        S("Beech Tree")},
}
moretrees.beech_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 8,
	seed_diff = 2,
	rarity = 50,
	max_count = 20,
}
]]--

--  moretrees.beech_model={
--      axiom="FFFFFBFB",
--      rules_a="[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fd]]////[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fd]]////[&&&GGF[++^Fd][--&Fd]//Fd[+^Fd][--&Fdd]]",
--      rules_b="[&&&F[++^Fd][--&d]//d[+^d][--&d]]////[&&&F[++^Fd][--&d]//d[+^d][--&d]]////[&&&F[++^Fd][--&Fd]//d[+^d][--&d]]",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:beech_trunk",
--      leaves="moretrees:beech_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=true
--  }
