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
minetest.register_node("ethereal:yellow_trunk", {
	description = S("Healing Tree Trunk"),
	tiles = {
		"ethereal_yellow_tree_top.png",
		"ethereal_yellow_tree_top.png",
		"ethereal_yellow_tree.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, puts_out_fire = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("ethereal:yellow_wood", {
	description = S("Healing Tree Wood"),
	tiles = {"ethereal_yellow_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = "ethereal:yellow_wood 4",
	recipe = {{"ethereal:yellow_trunk"}}
})
do_stair(
	"Healing Wood",
	"yellow_wood",
	"ethereal:yellow_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, put_out_fire = 1},
	{"ethereal_yellow_wood.png"},
	default.node_sound_wood_defaults())
    
minetest.register_node("ethereal:yellowleaves", {
	description = S("Healing Tree Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_yellow_leaves.png"},
	inventory_image = "ethereal_yellow_leaves.png",
	wield_image = "ethereal_yellow_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:yellow_tree_sapling"}, rarity = 50},
			{items = {"ethereal:yellowleaves"}}
		}
	},
	-- one leaf heals half a heart when eaten
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
	light_source = 9
})
default.register_leafdecay({
	trunks = {"ethereal:yellow_trunk"},
	leaves = {"ethereal:yellowleaves", "ethereal:golden_apple"},
	radius = 3
})

register_sapling("ethereal:yellow_tree", "Healing", "ethereal_yellow_tree_sapling", 19)

function ethereal.grow_yellow_tree(pos)
	add_tree(pos, 4, 0, 4, ethereal.yellowtree)
end

add_fence("yellowwood", "yellow_wood", "Healing Wood", "ethereal_yellow_wood")

add_schem({"default:dirt_with_snow"}, 0.01, {"taiga"}, 120, 140,
	ethereal.yellowtree, ethereal.alpine, nil, "default:dirt_with_snow", 8)
]]--
