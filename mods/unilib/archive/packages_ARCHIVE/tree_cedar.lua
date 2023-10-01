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
	{"cedar",        S("Cedar Tree"),     "cedar_cone",            S("Cedar Cone"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
}
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

--  moretrees.cedar_model={
--      axiom="FFFFFcccdddB///cFdFB////cFdFB///cFdFB///cFdFA///cFdFA///cFdFB[FF]f",
--      rules_a="[&&&TTTT[++^TFdd][--&TFd]//Tdd[+^Fd][--&Fdd]]",
--      rules_b="[&&&TTT[++^Fdd][--&Fdd]//dd[+^d][--&Fd]]",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:cedar_trunk",
--      leaves="moretrees:cedar_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=true,
--      fruit="moretrees:cedar_cone",
--      fruit_chance=8
--  }
