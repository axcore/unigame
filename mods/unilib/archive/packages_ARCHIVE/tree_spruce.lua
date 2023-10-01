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
	{"spruce",       S("Spruce Tree"),    "spruce_cone",           S("Spruce Cone"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
}
moretrees.spruce_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 335,
	min_elevation = 20,
	temp_min = 0.9,
	temp_max = 0.7,
	rarity = 50,
	max_count = 5,
}
]]--

--  moretrees.spruce_model1={
--      axiom="FFFFFAFFFFFFBFFFFFFCFFFFFFDFFFFFF[&&&F^^FF][&&&++F^^FF][&&&++++F^^FF][&&&++++++F^^FF][&&&--F^^FF][&&&----F^^FF][FFFFf]",
--      rules_a="[&&&FFFFFF^^FFF][&&&++FFFFFF^^FFF][&&&++++FFFFFF^^FFF][&&&++++++FFFFFF^^FFF][&&&--FFFFFF^^FFF][&&&----FFFFFF^^FFF]",
--      rules_b="[&&&FFFFF^^FFF][&&&++FFFFF^^FFF][&&&++++FFFFF^^FFF][&&&++++++FFFFF^^FFF][&&&--FFFFF^^FFF][&&&----FFFFF^^FFF]",
--      rules_c="[&&&FFFF^^FFF][&&&++FFFF^^FFF][&&&++++FFFF^^FFF][&&&++++++FFFF^^FFF][&&&--FFFF^^FFF][&&&----FFFF^^FFF]",
--      rules_d="[&&&FFF^^FFF][&&&++FFF^^FFF][&&&++++FFF^^FFF][&&&++++++FFF^^FFF][&&&--FFF^^FFF][&&&----FFF^^FFF]",
--      trunk="moretrees:spruce_trunk",
--      leaves="moretrees:spruce_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="crossed",
--      thin_branches=true,
--      fruit="moretrees:spruce_cone",
--      fruit_chance=8
--  }

--  moretrees.spruce_model2={
--      axiom="FFFFFFBFFFFFFCFFFFFFDFFFFFF[&&&F^^FF][&&&++F^^FF][&&&++++F^^FF][&&&++++++F^^FF][&&&--F^^FF][&&&----F^^FF][FFFFf]",
--      rules_b="[&&&FFFFF^^FFF][&&&++FFFFF^^FFF][&&&++++FFFFF^^FFF][&&&++++++FFFFF^^FFF][&&&--FFFFF^^FFF][&&&----FFFFF^^FFF]",
--      rules_c="[&&&FFFF^^FFF][&&&++FFFF^^FFF][&&&++++FFFF^^FFF][&&&++++++FFFF^^FFF][&&&--FFFF^^FFF][&&&----FFFF^^FFF]",
--      rules_d="[&&&FFF^^FFF][&&&++FFF^^FFF][&&&++++FFF^^FFF][&&&++++++FFF^^FFF][&&&--FFF^^FFF][&&&----FFF^^FFF]",
--      trunk="moretrees:spruce_trunk",
--      leaves="moretrees:spruce_leaves",
--      angle=30,
--      iterations=2,
--      random_level=0,
--      trunk_type="crossed",
--      thin_branches=true,
--      fruit="moretrees:spruce_cone",
--      fruit_chance=8
--  }

--[[
-- Code to spawn a spruce tree
function moretrees.grow_spruce(pos)
	minetest.swap_node(pos, biome_lib.air)
	if math.random(1,2) == 1 then
		minetest.spawn_tree(pos, moretrees.spruce_model1)
	else
		minetest.spawn_tree(pos, moretrees.spruce_model2)
	end
end
]]--
