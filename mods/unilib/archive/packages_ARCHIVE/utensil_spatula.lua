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
minetest.register_node("bbq:spatula", {
	description = ("Spatula"),
	inventory_image = "bbq_spatula.png",
	wield_image = "bbq_spatula.png",
	groups = {dig_immediate = 3, cracky=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"bbq_spatula_tile.png", "bbq_spatula_tile.png",
		"bbq_spatula_tile.png", "bbq_spatula_tile.png",
		"bbq_spatula_tile.png", "bbq_spatula_tile.png",
	},
	groups = {vessel = 1, dig_immediate = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
				{-0.15, -0.45, 0.5, 0.125, -.218, 0.45,},
				{-0.105, -0.218, 0.5, 0.085, -0.19, 0.45,},
				{-0.0625, -0.19, 0.5, 0.03125, .5, 0.45,},
--				{-0.15, -0.45, 0.5, 0.125, -.1, 0.45,},
		},
	},
	on_use = on_use_play_sound("bbq_sizzle"),
})
minetest.register_craft( {
	output = "bbq:spatula",
	recipe = {
		{"", "default:tin_ingot", ""},
		{"", "default:tin_ingot", ""},
		{"", "default:stick", ""}
	}
})
]]--
