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
	{"birch",        S("Birch Tree")},
}
moretrees.birch_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 5,
	seed_diff = 334,
	min_elevation = 10,
	max_elevation = 15,
	temp_min = 0.9,
	temp_max = 0.3,
	rarity = 50,
	max_count = 10,
}
]]--

--  moretrees.birch_model1={
--      axiom="FFFFFdddccA/FFFFFFcA/FFFFFFcB",
--      rules_a="[&&&dddd^^ddddddd][&&&---dddd^^ddddddd][&&&+++dddd^^ddddddd][&&&++++++dddd^^ddddddd]",
--      rules_b="[&&&ddd^^ddddd][&&&---ddd^^ddddd][&&&+++ddd^^ddddd][&&&++++++ddd^^ddddd]",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:birch_trunk",
--      leaves="moretrees:birch_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=true
--  }

--  moretrees.birch_model2={
--      axiom="FFFdddccA/FFFFFccA/FFFFFccB",
--      rules_a="[&&&dFFF^^FFFdd][&&&---dFFF^^FFFdd][&&&+++dFFF^^FFFdd][&&&++++++dFFF^^FFFdd]",
--      rules_b="[&&&dFF^^FFFd][&&&---dFFF^^FFFd][&&&+++dFF^^FFFd][&&&++++++dFF^^FFFd]",
--      rules_c="/",
--      rules_d="F",
--      trunk="moretrees:birch_trunk",
--      leaves="moretrees:birch_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="single",
--      thin_branches=true
--  }

--[[
-- Code to spawn a birch tree
function moretrees.grow_birch(pos)
	minetest.swap_node(pos, biome_lib.air)
	if math.random(1,2) == 1 then
		minetest.spawn_tree(pos, moretrees.birch_model1)
	else
		minetest.spawn_tree(pos, moretrees.birch_model2)
	end
end
]]--
