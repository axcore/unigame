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
minetest.register_node("ethereal:willow_trunk", {
	description = S("Willow Trunk"),
	tiles = {
		"ethereal_willow_trunk_top.png",
		"ethereal_willow_trunk_top.png",
		"ethereal_willow_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})

minetest.register_node("ethereal:willow_wood", {
	description = S("Willow Wood"),
	tiles = {"ethereal_willow_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node
})
minetest.register_craft({
	output = "ethereal:willow_wood 4",
	recipe = {{"ethereal:willow_trunk"}}
})
do_stair(
	"Willow Wood",
	"willow_wood",
	"ethereal:willow_wood",
	{choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	{"ethereal_willow_wood.png"},
	default.node_sound_wood_defaults())
    
minetest.register_node("ethereal:willow_twig", {
	description = S("Willow Twig"),
	drawtype = "plantlike",
	tiles = {"ethereal_willow_twig.png"},
	inventory_image = "ethereal_willow_twig.png",
	wield_image = "ethereal_willow_twig.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	visual_scale = leafscale,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:willow_sapling"}, rarity = 50},
			{items = {"ethereal:willow_twig"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})
default.register_leafdecay({
	trunks = {"ethereal:willow_trunk"},
	leaves = {"ethereal:willow_twig"},
	radius = 3
})

register_sapling("ethereal:willow", "Willow", "ethereal_willow_sapling", 14)

function ethereal.grow_willow_tree(pos)
	add_tree(pos, 5, 0, 5, ethereal.willow)
end

add_fence("willow", "willow_wood", "Willow", "ethereal_willow_wood")

add_schem({"ethereal:gray_dirt"}, 0.02, {"grayness"}, 1, 100,
	ethereal.willow, ethereal.grayness, nil,
	"ethereal:gray_dirt", 6)
]]--
