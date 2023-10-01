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
minetest.register_node("lib_ecology:logpile", {
	description = "Log Pile",
	tiles = {
		"default_tree.png^[transformR90",
		"default_tree.png^[transformR90",
		"default_tree.png^[transformR90",
		"default_tree.png^[transformR90",
		"default_tree_top.png",
		"default_tree_top.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.5, -0.0625, -0.125, 0.5}, -- NodeBox1
			{0.0625, -0.4375, -0.5, 0.5, -0.125, 0.5}, -- NodeBox2
			{0.125, -0.5, -0.5, 0.4375, -0.0625, 0.5}, -- NodeBox3
			{-0.4375, -0.5, -0.5, -0.125, -0.0625, 0.5}, -- NodeBox4
			{-0.125, -0.0625, -0.5, 0.1875, 0.375, 0.5}, -- NodeBox5
			{-0.1875, 0, -0.5, 0.25, 0.3125, 0.5}, -- NodeBox6
		}
	},
	groups = {choppy=3, oddly_breakable_by_hand=1, flammable=1, falling_node=1},
	drop = "default:tree 3",
})

minetest.register_craft( {
	output = "lib_ecology:logpile 1",
	recipe = {
		{ "", "default:tree", "" },
		{ "default:tree", "", "default:tree" }
	}
})
]]--
