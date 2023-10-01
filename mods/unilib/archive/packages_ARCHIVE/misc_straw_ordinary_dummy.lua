---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_farming
-- Code:    MIT
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("castle_farming:straw_dummy", {
	description = S("Training Dummy"),
	tiles = {"castle_straw_dummy.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3},
	sounds = default.node_sound_leaves_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.125, 0, 0.1875, 0.125}, -- right_leg
			{0, -0.5, -0.125, 0.25, 0.1875, 0.125}, -- left_leg
			{-0.25, 0.1875, -0.1875, 0.25, 0.875, 0.125}, -- torso
			{0.25, 0.1875, -0.125, 0.5, 0.875, 0.125}, -- left_arm
			{-0.5, 0.1875, -0.125, -0.25, 0.875, 0.125}, -- right_arm
			{-0.25, 0.875, -0.25, 0.25, 1.3125, 0.1875}, -- head
		}
	}
})
minetest.register_craft({
	output = "castle_farming:straw_dummy",
	recipe = {
		{"group:stick", "castle_farming:bound_straw","group:stick"},
		{"", "castle_farming:bound_straw",""},
		{"group:stick", "","group:stick"},
	},
})

local stick_burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack("default:stick")}}).time

minetest.register_craft({
	type = "fuel",
	recipe = "castle_farming:straw_dummy",
	burntime = 10*2 + 4*stick_burn_time
})
]]--
