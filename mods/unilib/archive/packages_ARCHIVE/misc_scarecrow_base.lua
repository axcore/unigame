---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("farming:scarecrow_bottom", {
	description = S("Scarecrow Bottom"),
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	tiles = {"default_wood.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -8/16, -1/16, 1/16, 8/16, 1/16},
			{-12/16, 4/16, -1/16, 12/16, 2/16, 1/16},
		}
	},
	groups = {snappy = 3, flammable = 2}
})
minetest.register_craft({
	output = "farming:scarecrow_bottom",
	recipe = {
		{"", "group:stick", ""},
		{"group:stick", "group:stick", "group:stick"},
		{"", "group:stick", ""}
	}
})
]]--
