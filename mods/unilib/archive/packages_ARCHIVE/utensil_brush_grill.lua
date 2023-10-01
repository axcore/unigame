---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("bbq:grill_brush", {
	description = ("Grill Brush"),
	inventory_image = "bbq_grill_brush.png",
	wield_image = "bbq_grill_brush.png",
	groups = {dig_immediate = 3, cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"bbq_grill_brush_hang_top.png", "bbq_grill_brush_hang.png",
		"bbq_grill_brush_hang.png", "bbq_grill_brush_hang.png",
		"bbq_grill_brush_hang.png", "bbq_grill_brush_hang.png",
	},
	groups = {vessel = 1, dig_immediate = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
				{-0.12, -0.5, 0.49, 0.12, -.467, 0.48,},
				{-0.15, -0.467, 0.5, 0.15, -.2225, 0.45,},
				{-0.125, -0.44, 0.5, 0.125, -.25, 0.35,},
				{-0.03, -0.2225, 0.5, 0.03, 0.13, 0.45,},
				{-0.0625, 0.13	, 0.5, 0.0625, 0.485, 0.45,},
				{-0.03, .485, 0.5, 0.03, .5, 0.45,},
		},
	},
	on_use = on_use_play_sound("bbq_grill_brush", true),
})
minetest.register_craft({
	output = "bbq:grill_brush",
	recipe = {
		{"", "default:tin_ingot", "farming:cotton"},
		{"", "default:tin_ingot", ""},
		{"", "default:stick", ""}
	}
})
]]--
