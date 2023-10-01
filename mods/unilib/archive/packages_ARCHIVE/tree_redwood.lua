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
minetest.register_node("ethereal:redwood_trunk", {
	description = S("Redwood Trunk"),
	tiles = {
		"ethereal_redwood_trunk_top.png",
		"ethereal_redwood_trunk_top.png",
		"ethereal_redwood_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("ethereal:redwood_wood", {
	description = S("Redwood Wood"),
	tiles = {"ethereal_redwood_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = "ethereal:redwood_wood 4",
	recipe = {{"ethereal:redwood_trunk"}}
})
do_stair(
	"Redwood",
	"redwood_wood",
	"ethereal:redwood_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"ethereal_redwood_wood.png"},
	default.node_sound_wood_defaults())
    
minetest.register_node("ethereal:redwood_leaves", {
	description = S("Redwood Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_redwood_leaves.png"},
	inventory_image = "ethereal_redwood_leaves.png",
	wield_image = "ethereal_redwood_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:redwood_sapling"}, rarity = 50},
			{items = {"ethereal:redwood_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})
default.register_leafdecay({
	trunks = {"ethereal:redwood_trunk"},
	leaves = {"ethereal:redwood_leaves"},
	radius = 3
})

register_sapling("ethereal:redwood", "Redwood", "ethereal_redwood_sapling", 21)
register_sapling("ethereal:giant_redwood", "Giant Redwood",
		"ethereal_giant_redwood_sapling", 33)

function ethereal.grow_redwood_tree(pos)
	add_tree(pos, 4, 0, 4, ethereal.redwood_small_tree)
end
function ethereal.grow_giant_redwood_tree(pos)
	add_tree(pos, 7, 0, 7, ethereal.redwood_tree)
end

minetest.register_craft({
	output = "ethereal:giant_redwood_sapling",
	recipe = {{"ethereal:redwood_sapling", "ethereal:redwood_sapling"}}
})

add_fence("redwood", "redwood_wood", "Redwood", "ethereal_redwood_wood")

add_schem({"default:dirt_with_dry_grass"}, 0.0025, {"mesa"}, 1, 100,
	ethereal.redwood_tree, ethereal.mesa, nil,
	"default:dirt_with_dry_grass", 8)   
]]--
