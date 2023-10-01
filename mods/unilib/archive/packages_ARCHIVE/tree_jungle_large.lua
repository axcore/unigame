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
	{"jungletree",   S("Jungle Tree"),     nil,                    nil, nil, nil, "default_junglesapling.png"  },
}
moretrees.jungletree_biome = {
	surface = {
		"default:dirt",
		"default:dirt_with_grass",
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2"
	},
	avoid_nodes = {"moretrees:jungletree_trunk"},
	max_count = 12,
	avoid_radius = 3,
	rarity = 85,
	seed_diff = 329,
	min_elevation = 1,
	near_nodes = {"default:jungletree"},
	near_nodes_size = 6,
	near_nodes_vertical = 2,
	near_nodes_count = 1,
	plantlife_limit = -0.9,
}

moretrees.jungletree_model={
	axiom=nil,
	rules_a=nil,
	rules_b=nil,
	trunk="moretrees:jungletree_trunk",
	leaves="default:jungleleaves",
	leaves2=nil,
	leaves2_chance=nil,
	angle=45,
	iterations=nil,
	random_level=2,
	trunk_type=nil,
	thin_branches=true,
	fruit_chance=15,
	fruit="vines:vine"
}

-- Code to spawn jungle trees

moretrees.jt_axiom1 = "FFFA"
moretrees.jt_rules_a1 = "FFF[&&-FBf[&&&Ff]^^^Ff][&&+FBFf[&&&FFf]^^^Ff][&&---FBFf[&&&Ff]^^^Ff][&&+++FBFf[&&&Ff]^^^Ff]F/A"
moretrees.jt_rules_b1 = "[-Ff&f][+Ff&f]B"

moretrees.jt_axiom2 = "FFFFFA"
moretrees.jt_rules_a2 = "FFFFF[&&-FFFBF[&&&FFff]^^^FFf][&&+FFFBFF[&&&FFff]^^^FFf][&&---FFFBFF[&&&FFff]^^^FFf][&&+++FFFBFF[&&&FFff]^^^FFf]FF/A"
moretrees.jt_rules_b2 = "[-FFf&ff][+FFf&ff]B"

moretrees.ct_rules_a1 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b1 = "[-FBf][+FBf]"

moretrees.ct_rules_a2 = "FF[FF][&&-FBF][&&+FBF][&&---FBF][&&+++FBF]F/A"
moretrees.ct_rules_b2 = "[-fB][+fB]"

function moretrees.grow_jungletree(pos)
	local r1 = math.random(2)
	local r2 = math.random(3)
	if r1 == 1 then
		moretrees.jungletree_model.leaves2 = "moretrees:jungletree_leaves_red"
	else
		moretrees.jungletree_model.leaves2 = "moretrees:jungletree_leaves_yellow"
	end
	moretrees.jungletree_model.leaves2_chance = math.random(25, 75)

	if r2 == 1 then
		moretrees.jungletree_model.trunk_type = "single"
		moretrees.jungletree_model.iterations = 2
		moretrees.jungletree_model.axiom = moretrees.jt_axiom1
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a1
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b1
	elseif r2 == 2 then
		moretrees.jungletree_model.trunk_type = "double"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	elseif r2 == 3 then
		moretrees.jungletree_model.trunk_type = "crossed"
		moretrees.jungletree_model.iterations = 4
		moretrees.jungletree_model.axiom = moretrees.jt_axiom2
		moretrees.jungletree_model.rules_a = moretrees.jt_rules_a2
		moretrees.jungletree_model.rules_b = moretrees.jt_rules_b2
	end

	minetest.swap_node(pos, biome_lib.air)
	local leaves = minetest.find_nodes_in_area({x = pos.x-1, y = pos.y, z = pos.z-1}, {x = pos.x+1, y = pos.y+10, z = pos.z+1}, "default:leaves")
	for leaf in ipairs(leaves) do
			minetest.swap_node(leaves[leaf], biome_lib.air)
	end
	minetest.spawn_tree(pos, moretrees.jungletree_model)
end
]]--
