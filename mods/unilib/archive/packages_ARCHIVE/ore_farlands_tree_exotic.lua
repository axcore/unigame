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
minetest.override_item("default:apple", {
	description = "Leaves with Apple",
	drawtype = "allfaces_optional",
	tiles = {
		"default_leaves.png^fruit_apple_leaves.png",
	},
	special_tiles = {"default_leaves_simple.png^fruit_apple_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, not_in_creative_inventory=1, leaves = 1},
	drop = "default:leaves",
	waving = 1,
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:apple")
	end,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, 
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, 
		}
	},
	on_rightclick = function(pos)
	minetest.set_node(pos, {name="default:leaves"})
	pos.y = pos.y-0.5
	--minetest.add_item(pos, "fruit:apple")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:leaves_with_peach", {
	description = "Leaves with Peach",
	drawtype = "allfaces_optional",
	tiles = {
		"default_leaves.png^fruit_peach_leaves.png",
	},
	special_tiles = {"default_leaves_simple.png^fruit_peach_leaves.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, not_in_creative_inventory=1, leaves = 1},
	drop = "default:leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:peach")
	end,
	on_rightclick = function(pos)
	minetest.set_node(pos, {name="default:leaves"})
	pos.y = pos.y-0.5
	--minetest.add_item(pos, "fruit:peach")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:leaves_with_pear", {
	description = "Leaves with Pear",
	drawtype = "allfaces_optional",
	tiles = {
		"default_leaves.png^fruit_pear_leaves.png",
	},
	special_tiles = {"default_leaves_simple.png^fruit_pear_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, not_in_creative_inventory=1, leaves = 1},
	drop = "default:leaves",
	waving = 1,
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:pear")
	end,
	on_rightclick = function(pos)
	minetest.set_node(pos, {name="default:leaves"})
	pos.y = pos.y-0.5
	--minetest.add_item(pos, "fruit:pear")
	end,
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("fruit:leaves_with_plum", {
	description = "Leaves with Plum",
	drawtype = "allfaces_optional",
	tiles = {
		"default_leaves.png^fruit_plum_leaves.png",
	},
	special_tiles = {"default_leaves_simple.png^fruit_plum_leaves.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, not_in_creative_inventory=1, leaves = 1},
	drop = "default:leaves",
	on_destruct = function(pos)
		minetest.add_item(pos, "fruit:plum")
	end,
	on_rightclick = function(pos)
	minetest.set_node(pos, {name="default:leaves"})
	pos.y = pos.y-0.5
	--minetest.add_item(pos, "fruit:plum")
	end,
	sounds = default.node_sound_leaves_defaults()
})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:apple",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
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
    
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_peach",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
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
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_pear",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
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

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "fruit:leaves_with_plum",
		wherein        = "default:leaves",
		clust_scarcity = 15 * 15 * 15,
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
