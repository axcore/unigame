---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xdecor.register("barrel", {
	description = S("Barrel"),
	tiles = {"xdecor_barrel_top.png", "xdecor_barrel_top.png", "xdecor_barrel_sides.png"},
	on_place = minetest.rotate_node,
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})
minetest.register_craft({
	output = "xdecor:barrel",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"default:iron_lump", "", "default:iron_lump"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
]]--
