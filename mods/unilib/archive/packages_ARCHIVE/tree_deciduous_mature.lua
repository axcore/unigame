---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_ecology:tree_generic_trunk_tree_03", {
	description = S("Tree 03 Trunk"),
	tiles = {
		"default_tree_top.png",
		"default_tree_top.png",
		"lib_ecology_tree_generic_trunk_tree_03a.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	is_ground_content = false,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

minetest.register_node("lib_ecology:tree_leaves_red", {
	description = S("Leaves - Red"),
	drawtype = "allfaces_optional",
	tiles = {"lib_ecology_tree_leaves_red.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"lib_ecology:tree_leaves_red"}},
			{items = {"lib_ecology:stick"}, rarity = 10},
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})
minetest.register_node("lib_ecology:tree_leaves_yellow", {
	description = S("Leaves - Yellow"),
	drawtype = "allfaces_optional",
	tiles = {"lib_ecology_tree_leaves_yellow.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"lib_ecology:tree_leaves_yellow"}},
			{items = {"lib_ecology:stick"}, rarity = 10},
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})
minetest.register_node("lib_ecology:tree_leaves_green", {
	description = S("Leaves - Green"),
	drawtype = "allfaces_optional",
	tiles = {"lib_ecology_tree_leaves_green.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"lib_ecology:tree_leaves_green"}},
			{items = {"lib_ecology:stick"}, rarity = 10},
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})
minetest.register_node("lib_ecology:tree_leaves_green_2", {
	description = S("Leaves - Green (#FF0000:10)"),
	drawtype = "allfaces_optional",
	tiles = {"lib_ecology_tree_leaves_green.png^[colorize:#FF0000:10"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"lib_ecology:tree_leaves_green"}},
			{items = {"lib_ecology:stick"}, rarity = 10},
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})
minetest.register_node("lib_ecology:tree_leaves_green_3", {
	description = S("Leaves - Green (#FFFF00:30)"),
	drawtype = "allfaces_optional",
	tiles = {"lib_ecology_tree_leaves_green.png^[colorize:#FFFF00:30"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"lib_ecology:tree_leaves_green"}},
			{items = {"lib_ecology:stick"}, rarity = 10},
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})
]]--
