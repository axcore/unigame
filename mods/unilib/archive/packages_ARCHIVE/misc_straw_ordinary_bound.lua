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
minetest.register_node("castle_farming:bound_straw", {
	description = S("Bound Straw"),
	drawtype = "normal",
	tiles = {"castle_straw_bale.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
})
minetest.register_craft({
	output = "castle_farming:bound_straw 6",
	type = "shapeless",
	recipe = {"farming:straw", "farming:straw", "farming:straw", "farming:straw", "farming:straw", "farming:straw", "ropes:ropesegment",}
})
minetest.register_craft({
	output = "castle_farming:bound_straw",
	type = "shapeless",
	recipe = {"farming:straw", "farming:cotton",}
})
minetest.register_craft({
	type = "fuel",
	recipe = "castle_farming:bound_straw",
	burntime = 10
})
]]--
