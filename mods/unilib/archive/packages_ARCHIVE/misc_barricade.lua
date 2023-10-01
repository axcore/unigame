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
xdecor.register("baricade", {
	description = S("Baricade"),
	drawtype = "plantlike",
	paramtype2 = "facedir",
	inventory_image = "xdecor_baricade.png",
	tiles = {"xdecor_baricade.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	damage_per_second = 4,
	selection_box = xdecor.nodebox.slab_y(0.3),
	collision_box = xdecor.pixelbox(2, {{0, 0, 1, 2, 2, 0}})
})
minetest.register_craft({
	output = "xdecor:baricade",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"", "default:steel_ingot", ""},
		{"group:stick", "", "group:stick"}
	}
})
]]--
