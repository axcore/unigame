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
minetest.register_node("ethereal:sakura_trunk", {
	description = S("Sakura Trunk"),
	tiles = {
		"ethereal_sakura_trunk_top.png",
		"ethereal_sakura_trunk_top.png",
		"ethereal_sakura_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("ethereal:sakura_wood", {
	description = S("Sakura Wood"),
	tiles = {"ethereal_sakura_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = "ethereal:sakura_wood 4",
	recipe = {{"ethereal:sakura_trunk"}}
})
do_stair(
	"Sakura Wood",
	"sakura_wood",
	"ethereal:sakura_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"ethereal_sakura_wood.png"},
	default.node_sound_wood_defaults())
    
minetest.register_node("ethereal:sakura_leaves", {
	description = S("Sakura Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_sakura_leaves.png"},
	inventory_image = "ethereal_sakura_leaves.png",
	wield_image = "ethereal_sakura_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:sakura_sapling"}, rarity = 30},
			{items = {"ethereal:sakura_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

minetest.register_node("ethereal:sakura_leaves2", {
	description = S("Sakura Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_sakura_leaves2.png"},
	inventory_image = "ethereal_sakura_leaves2.png",
	wield_image = "ethereal_sakura_leaves2.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:sakura_sapling"}, rarity = 30},
			{items = {"ethereal:sakura_leaves2"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

default.register_leafdecay({
	trunks = {"ethereal:sakura_trunk"},
	leaves = {"ethereal:sakura_leaves", "ethereal:sakura_leaves2"},
	radius = 3
})

register_sapling("ethereal:sakura", "Sakura", "ethereal_sakura_sapling", 10)

function ethereal.grow_sakura_tree(pos)

	if math.random(10) == 1 then
		add_tree(pos, 4, 0, 3, ethereal.sakura_tree,
			{{"ethereal:sakura_leaves", "ethereal:sakura_leaves2"}})
	else
		add_tree(pos, 4, 0, 3, ethereal.sakura_tree)
	end
end

add_fence("sakura", "sakura_wood", "Sakura", "ethereal_sakura_wood")

add_schem({"ethereal:bamboo_dirt"}, 0.001, {"sakura"}, 7, 100,
	ethereal.sakura_tree, ethereal.sakura, nil,
	"ethereal:bamboo_dirt", 6)
]]--
