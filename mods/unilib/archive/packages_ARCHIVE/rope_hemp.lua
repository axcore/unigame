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
minetest.register_node("farming:hemp_rope", {
	description = S("Hemp Rope"),
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	tiles = {"farming_hemp_rope.png"},
	wield_image = "farming_hemp_rope.png",
	inventory_image = "farming_hemp_rope.png",
	drawtype = "plantlike",
	groups = {flammable = 2, choppy = 3, oddly_breakable_by_hand = 3},
	sounds =  default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7}
	}
})
minetest.register_craft( {
	output = "farming:hemp_rope 6",
	recipe = {
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"},
		{"farming:cotton", "farming:cotton", "farming:cotton"},
		{"farming:hemp_fibre", "farming:hemp_fibre", "farming:hemp_fibre"}
	}
})
]]--
