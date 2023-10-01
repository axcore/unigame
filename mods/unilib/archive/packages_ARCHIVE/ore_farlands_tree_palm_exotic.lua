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
minetest.register_node("fruit:palm_leaves_coconut", {
	description = "Palm Leaves (coconut)",
	drawtype = "allfaces_optional",
	paramtype = "light",
	tiles = {
		"fruit_palmleaves_coconut.png",
	},
	special_tiles = {"fruit_palmleaves_coconut.png"},
	waving = 1,
	groups = {snappy = 2, flammable = 1, leaves = 1, leafdecay = 3,},
	sounds = default.node_sound_leaves_defaults(),
	on_destruct = function(pos, oldnode)
		minetest.add_item(pos, "fruit:coconut")
	end,
	on_rightclick = function(pos)
	minetest.set_node(pos, {name="mapgen:palm_leaves"})
	pos.y = pos.y-0.5
	--minetest.add_item(pos, "fruit:coconut")
	end,
})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:palm_leaves_coconut",
		wherein        = "mapgen:palm_leaves",
		clust_scarcity = 5 * 5 * 5,
		clust_num_ores = 4,
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
