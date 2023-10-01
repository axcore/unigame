---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    glass_stained
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("glass_stained:pane_bar_top_pane_single", {
	description = "Spiked Steel Railing Pane (Single)",
	drawtype = "nodebox",
	tiles = {"blank.png", "blank.png", "glass_stained_bar_fancy.png"},
	wield_image = "glass_stained_bar_fancy.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	node_box = {
		type = "fixed",
		fixed = thick_nodeboxes["single"],
	},
	selection_box = {
		type = "fixed",
		fixed = selection_boxes["single"],
	},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_metal_defaults(),
})
minetest.register_craft({
	output = "glass_stained:pane_bar_top_pane_single",
	recipe = {
		{"xpanes:bar_top_flat"}
	},
})
minetest.register_craft({
	output = "glass_stained:pane_bar_top_pane_single",
	recipe = {
		{"glass_stained:pane_bar_top_pane_offset"}
	},
})

minetest.register_node("glass_stained:pane_bar_top_pane_offset", {
	description = "Spiked Steel Railing Pane (Offset)",
	drawtype = "nodebox",
	tiles = {"blank.png", "blank.png", "glass_stained_bar_fancy.png"},
	wield_image = "glass_stained_bar_fancy.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	node_box = {
		type = "fixed",
		fixed = thick_nodeboxes["offset"],
	},
	selection_box = {
		type = "fixed",
		fixed = selection_boxes["offset"],
	},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_metal_defaults(),
})
minetest.register_craft({
	output = "glass_stained:pane_bar_top_pane_offset",
	recipe = {
		{"glass_stained:pane_bar_top_pane_single"}
	},
})
]]--
