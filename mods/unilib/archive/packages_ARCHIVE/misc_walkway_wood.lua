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
minetest.register_node("decoblocks:plank_walkway", {
	description = "Wood Plank Walkway",
	tiles = {
		"decoblocks_wood_planks.png",
		"decoblocks_wood_planks.png",
		"default_wood.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.5, -0.3125, 0.5, 0.5}, -- NodeBox1
			{-0.25, 0.4375, -0.4375, -0.0625, 0.5, 0.5}, -- NodeBox2
			{0, 0.4375, -0.5, 0.1875, 0.5, 0.5}, -- NodeBox3
			{0.25, 0.4375, -0.375, 0.4375, 0.5, 0.5}, -- NodeBox4
		}
	},
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy=1,}
})
minetest.register_craft({
	output = 'decoblocks:plank_walkway 12',
	recipe = {
		{'group:wood', '', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', '', 'group:wood'},
	}
})
]]--
