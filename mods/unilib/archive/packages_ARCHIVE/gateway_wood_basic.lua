---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    castle/castle_gates
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("castle_gates:gate_panel", {
	drawtype = "nodebox",
	description = S("Gate Door"),
	_doc_items_longdesc = castle_gates.doc.gate_panel_longdesc,
	_doc_items_usagehelp = castle_gates.doc.gate_panel_usagehelp,
	groups = {choppy = 1, castle_gate = 1},
	tiles = {
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
		}
	},
	on_rightclick = castle_gates.trigger_gate,
})
minetest.register_craft({
	output = "castle_gates:gate_panel 8",
	recipe = {
		{"stairs:slab_wood","stairs:slab_wood", ""},
		{"stairs:slab_wood","stairs:slab_wood", ""},
	},
})
minetest.register_craft({
	output = "castle_gates:gate_panel",
	type = "shapeless",
	recipe = {"castle_gates:gate_edge_handle"},
})

minetest.register_node("castle_gates:gate_edge", {
	drawtype = "nodebox",
	description = S("Gate Door Edge"),
	_doc_items_longdesc = castle_gates.doc.gate_edge_longdesc,
	_doc_items_usagehelp = castle_gates.doc.gate_edge_usagehelp,
	groups = {choppy = 1, castle_gate = 1},
	tiles = {
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90^(default_coal_block.png^[mask:castle_door_edge_mask.png^[transformFX)",
		"default_wood.png^[transformR90^(default_coal_block.png^[mask:castle_door_edge_mask.png)",
		},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
		}
	},
	_gate_edges = {right=true},
	on_rightclick = castle_gates.trigger_gate,
})
minetest.register_craft({
	output = "castle_gates:gate_edge",
	type = "shapeless",
	recipe = {"castle_gates:gate_panel"},
})

minetest.register_node("castle_gates:gate_edge_handle", {
	drawtype = "nodebox",
	description = S("Gate Door With Handle"),
	_doc_items_longdesc = castle_gates.doc.gate_edge_handle_longdesc,
	_doc_items_usagehelp = castle_gates.doc.gate_edge_handle_usagehelp,
	groups = {choppy = 1, castle_gate = 1},
	tiles = {
		"castle_steel.png^(default_wood.png^[mask:castle_door_side_mask.png^[transformR90)",
		"castle_steel.png^(default_wood.png^[mask:castle_door_side_mask.png^[transformR270)",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_door_side_mask.png)",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:(castle_door_side_mask.png^[transformFX))",
		"default_wood.png^[transformR90^(default_coal_block.png^[mask:castle_door_edge_mask.png^[transformFX)^(castle_steel.png^[mask:castle_door_handle_mask.png^[transformFX)",
		"default_wood.png^[transformR90^(default_coal_block.png^[mask:castle_door_edge_mask.png)^(castle_steel.png^[mask:castle_door_handle_mask.png)",
		},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
			{4/16, -4/16, -2/16, 6/16, 4/16, -3/16},
			{4/16, -4/16, -9/16, 6/16, 4/16, -10/16},
			{4/16, -4/16, -9/16, 6/16, -3/16, -3/16},
			{4/16, 4/16, -9/16, 6/16, 3/16, -3/16},
		}
	},
	_gate_edges = {right=true},
	on_rightclick = castle_gates.trigger_gate,
})
minetest.register_craft({
	output = "castle_gates:gate_edge_handle",
	type = "shapeless",
	recipe = {"castle_gates:gate_edge"},
})

minetest.register_node("castle_gates:gate_hinge", {
	drawtype = "nodebox",
	description = S("Gate Door With Hinge"),
	_doc_items_longdesc = castle_gates.doc.gate_hinge_longdesc,
	_doc_items_usagehelp = castle_gates.doc.gate_hinge_usagehelp,
	groups = {choppy = 1, castle_gate = 1},
	tiles = {
		"default_wood.png^[transformR90",
		},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
			{-10/16, -4/16, -10/16, -6/16, 4/16, -6/16},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, -0.25},
	},
	
	_gate_hinge = {axis="top", offset={"front","left"}},
	on_rightclick = castle_gates.trigger_gate,
})
minetest.register_craft({
	output = "castle_gates:gate_hinge 3",
	recipe = {
		{"", "castle_gates:gate_panel", ""},
		{"default:steel_ingot", "castle_gates:gate_panel", ""},
		{"", "castle_gates:gate_panel", ""}
	},
})
]]--
