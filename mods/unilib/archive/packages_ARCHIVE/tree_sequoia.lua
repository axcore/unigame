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
	{"sequoia",      S("Giant Sequoia")},
}
moretrees.sequoia_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 333,
	min_elevation = 0,
	max_elevation = 10,
	temp_min = 1,
	temp_max = -0.4,
	rarity = 90,
	max_count = 5,
}
]]--

--  moretrees.sequoia_model={
--      axiom="FFFFFFFFFFddccA///cccFddcFA///ddFcFA/cFFddFcdBddd/A/ccdcddd/ccAddddcFBcccAccFdFcFBcccc/BFdFFcFFdcccc/B",
--      rules_a="[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd][--&Fdd]]////[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd][--&Fdd]]////[&&&GGF[++^FFdd][--&Fddd]//Fdd[+^Fd][--&Fdd]]",
--      rules_b="[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]////[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]////[&&&GGF[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:sequoia_trunk",
--      leaves="moretrees:sequoia_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="crossed",
--      thin_branches=true
--  }
