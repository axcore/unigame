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
	{"fir",          S("Douglas Fir"),    "fir_cone",              S("Fir Cone"), {-0.2, -0.5, -0.2, 0.2, 0, 0.2}, 0.8 },
}
moretrees.fir_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 359,
	min_elevation = 25,
	temp_min = 0.9,
	temp_max = 0.3,
	rarity = 50,
	max_count = 10,
}

moretrees.fir_biome_snow = {
	surface = {"snow:dirt_with_snow", "snow:snow"},
	below_nodes = {"default:dirt", "default:dirt_with_grass", "snow:dirt_with_snow"},
	avoid_nodes = moretrees.avoidnodes,
	avoid_radius = 10,
	seed_diff = 359,
	rarity = 50,
	max_count = 10,
	check_air = false,
	delete_above = true,
	spawn_replace_node = true
}
]]--

--  moretrees.fir_model={
--      axiom="FFFAF[&&-F][&&+F][&&---F][&&+++F]Fff",
--      rules_a=nil,
--      rules_b=nil,
--      trunk="moretrees:fir_trunk",
--      leaves=nil,
--      angle=45,
--      iterations=7,
--      random_level=5,
--      trunk_type="single",
--      thin_branches=true,
--      fruit="moretrees:fir_cone",
--      fruit_chance=8
--  }

--[[
-- code to spawn fir trees

function moretrees.grow_fir(pos)
	if math.random(2) == 1 then
		moretrees.fir_model.leaves="moretrees:fir_leaves"
	else
		moretrees.fir_model.leaves="moretrees:fir_leaves_bright"
	end
	if math.random(2) == 1 then
		moretrees.fir_model.rules_a = moretrees.ct_rules_a1
		moretrees.fir_model.rules_b = moretrees.ct_rules_b1
	else
		moretrees.fir_model.rules_a = moretrees.ct_rules_a2
		moretrees.fir_model.rules_b = moretrees.ct_rules_b2
	end

	moretrees.fir_model.iterations = 7
	moretrees.fir_model.random_level = 5

	minetest.swap_node(pos, biome_lib.air)
	local leaves = minetest.find_nodes_in_area({x = pos.x, y = pos.y, z = pos.z}, {x = pos.x, y = pos.y+5, z = pos.z}, "default:leaves")
	for leaf in ipairs(leaves) do
		minetest.swap_node(leaves[leaf], biome_lib.air)
	end
	minetest.spawn_tree(pos,moretrees.fir_model)
end

-- same thing, but a smaller version that grows only in snow biomes

function moretrees.grow_fir_snow(pos)
	if math.random(2) == 1 then
		moretrees.fir_model.leaves="moretrees:fir_leaves"
	else
		moretrees.fir_model.leaves="moretrees:fir_leaves_bright"
	end
	if math.random(2) == 1 then
		moretrees.fir_model.rules_a = moretrees.ct_rules_a1
		moretrees.fir_model.rules_b = moretrees.ct_rules_b1
	else
		moretrees.fir_model.rules_a = moretrees.ct_rules_a2
		moretrees.fir_model.rules_b = moretrees.ct_rules_b2
	end

	moretrees.fir_model.iterations = 2
	moretrees.fir_model.random_level = 2

	minetest.swap_node(pos, biome_lib.air)
	local leaves = minetest.find_nodes_in_area({x = pos.x, y = pos.y, z = pos.z}, {x = pos.x, y = pos.y+5, z = pos.z}, "default:leaves")
	for leaf in ipairs(leaves) do
			minetest.swap_node(leaves[leaf], biome_lib.air)
	end
	minetest.spawn_tree(pos,moretrees.fir_model)
end
]]--
