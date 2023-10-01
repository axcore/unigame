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
minetest.register_node("ethereal:lemon_leaves", {
	description = S("Lemon Tree Leaves"),
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"ethereal_lemon_leaves.png"},
	inventory_image = "ethereal_lemon_leaves.png",
	wield_image = "ethereal_lemon_leaves.png",
	paramtype = "light",
	walkable = ethereal.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:lemon_tree_sapling"}, rarity = 25},
			{items = {"ethereal:lemon_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves
})

register_sapling("ethereal:lemon_tree", "Lemon", "ethereal_lemon_tree_sapling", 7)

function ethereal.grow_lemon_tree(pos)
	add_tree(pos, 2, 0, 2, ethereal.lemontree)
end

add_schem({"ethereal:grove_dirt"}, 0.002, {"mediterranean"}, 5, 50,
	ethereal.lemontree, ethereal.mediterranean)
]]--
