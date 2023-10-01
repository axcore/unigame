---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("fruit:leaves_with_berry", {
	description = "Leaves with Berry",
	drawtype = "allfaces_optional",
	tiles = {
		"default_leaves_simple.png^fruit_berry_leaves.png",
	},
	special_tiles = {"default_leaves_simple.png^fruit_berry_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, not_in_creative_inventory=1, leaves = 1},
	drop = "default:bush_leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:berry")
	end,
	on_rightclick = function(pos)
	minetest.set_node(pos, {name="default:bush_leaves"})
	--minetest.add_item(pos, "fruit:berry")
	end,
	sounds = default.node_sound_leaves_defaults()
})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_berry",
		wherein        = "default:bush_leaves",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 6,
		clust_size     = 4,
		y_min          = 0,
		y_max          = 31000,
		noise_params    = {
			offset = 0.5,
			scale = 1,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})
]]--
