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
minetest.register_node("ethereal:orange_leaves", {
	description = S("Orange Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_orange_leaves.png"},
	inventory_image = "ethereal_orange_leaves.png",
	wield_image = "ethereal_orange_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:orange_tree_sapling"}, rarity = 15},
			{items = {"ethereal:orange_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

register_sapling("ethereal:orange_tree", "Orange", "ethereal_orange_tree_sapling", 6)

function ethereal.grow_orange_tree(pos)
	add_tree(pos, 2, 0, 2, ethereal.orangetree)
end

add_schem({"ethereal:prairie_dirt"}, 0.01, {"prairie"}, 1, 100,
	ethereal.orangetree, ethereal.prairie)
]]--
