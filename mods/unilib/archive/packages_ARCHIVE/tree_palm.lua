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
minetest.register_node("ethereal:palm_trunk", {
	description = S("Palm Trunk"),
	tiles = {
		"moretrees_palm_trunk_top.png",
		"moretrees_palm_trunk_top.png",
		"moretrees_palm_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("ethereal:palm_wood", {
	description = S("Palm Wood"),
	tiles = {"moretrees_palm_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = "ethereal:palm_wood 4",
	recipe = {{"ethereal:palm_trunk"}}
})
do_stair(
	"Palm Wood",
	"palm_wood",
	"ethereal:palm_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"moretrees_palm_wood.png"},
	default.node_sound_wood_defaults())

minetest.register_node("ethereal:palmleaves", {
	description = S("Palm Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"moretrees_palm_leaves.png"},
	inventory_image = "moretrees_palm_leaves.png",
	wield_image = "moretrees_palm_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:palm_sapling"}, rarity = 10},
			{items = {"ethereal:palmleaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})
default.register_leafdecay({
	trunks = {"ethereal:palm_trunk"},
	leaves = {"ethereal:palmleaves", "ethereal:coconut"},
	radius = 3
})

register_sapling("ethereal:palm", "Palm", "moretrees_palm_sapling", 9)

function ethereal.grow_palm_tree(pos)
	add_tree(pos, 4, 0, 4, ethereal.palmtree)
end

add_fence("palm", "palm_wood", "Palm", "moretrees_palm_wood")

add_schem("default:sand", 0.0025, {"desert_ocean", "plains_ocean", "sandclay",
	"sandstone_ocean", "mesa_ocean", "grove_ocean", "deciduous_forest_ocean"}, 1, 1,
	ethereal.palmtree, 1)
]]--
