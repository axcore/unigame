---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:frost_tree", {
	description = S("Frost Tree"),
	tiles = {
		"ethereal_frost_tree_top.png",
		"ethereal_frost_tree_top.png",
		"ethereal_frost_tree.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("ethereal:frost_wood", {
	description = S("Frost Wood"),
	tiles = {"ethereal_frost_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = "ethereal:frost_wood 4",
	recipe = {{"ethereal:frost_tree"}}
})
do_stair(
	"Frost Wood",
	"frost_wood",
	"ethereal:frost_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, put_out_fire = 1},
	{"ethereal_frost_wood.png"},
	default.node_sound_wood_defaults())
    
minetest.register_node("ethereal:frost_leaves", {
	description = S("Frost Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_frost_leaves.png"},
	inventory_image = "ethereal_frost_leaves.png",
	wield_image = "ethereal_frost_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, puts_out_fire = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:frost_tree_sapling"}, rarity = 15},
			{items = {"ethereal:frost_leaves"}}
		}
	},
	light_source = 9,
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})
default.register_leafdecay({
	trunks = {"ethereal:frost_tree"},
	leaves = {"ethereal:frost_leaves"},
	radius = 3
})

register_sapling("ethereal:frost_tree", "Frost", "ethereal_frost_tree_sapling", 19)

function ethereal.grow_frost_tree(pos)
	add_tree(pos, 4, 0, 4, ethereal.frosttrees)
end

add_fence("frostwood", "frost_wood", "Frost", "ethereal_frost_wood")

add_schem({"ethereal:crystal_dirt"}, 0.01, {"frost", "frost_floatland"}, 1, 1750,
	ethereal.frosttrees, ethereal.frost, nil,
	"ethereal:crystal_dirt", 8)
]]--
