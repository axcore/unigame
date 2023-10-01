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
minetest.register_node("bbq:basting_brush", {
	description = ("Basting Brush"),
	inventory_image = "bbq_basting_brush.png",
	wield_image = "bbq_basting_brush.png",
	groups = {dig_immediate = 3, cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"bbq_basting_brush_hang.png", "bbq_basting_brush_hang.png",
		"bbq_basting_brush_hang.png", "bbq_basting_brush_hang.png",
		"bbq_basting_brush_hang.png", "bbq_basting_brush_hang.png",
	},
	groups = {vessel = 1, dig_immediate = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
				{-0.085, -0.45, 0.5, 0.085, -.2525, 0.45,},
				{-0.0625, -0.2525, 0.5, 0.0625, -.218, 0.45,},
				{-0.03, -0.218, 0.5, 0.03, 0.0	, 0.45,},
				{-0.0625, 0.0, 0.5, 0.0625, 0.465, 0.45,},
				{-0.03, .465, 0.5, 0.03, .5, 0.45,},
		},
	},
	on_use = on_use_play_sound("bbq_basting"),
})
minetest.register_craft({
	output = "bbq:basting_brush",
	recipe = {
		{"", "farming:cotton", ""},
		{"", "default:tin_ingot", ""},
		{"", "default:stick", ""}
	}
})
]]--
