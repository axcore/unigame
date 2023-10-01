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
minetest.register_node("castle_gates:portcullis_bars", {
	drawtype = "nodebox",
	description = S("Portcullis Bars"),
	_doc_items_longdesc = castle_gates.doc.portcullis_bars_longdesc,
	_doc_items_usagehelp = castle_gates.doc.portcullis_bars_usagehelp,
	groups = {castle_gate = 1, choppy = 1, flow_through = 1},
	tiles = {
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.5, 0.125, 0.5, -0.25}, -- middle bar
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.25}, -- side bar
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.25}, -- side bar
			{-0.375, 0.1875, -0.4375, 0.375, 0.3125, -0.3125}, -- crosspiece
			{-0.375, -0.3125, -0.4375, 0.375, -0.1875, -0.3125}, -- crosspiece
		}
	},
	on_rightclick = castle_gates.trigger_gate,
})
minetest.register_craft({
	output = "castle_gates:portcullis_bars 3",
	recipe = {
		{"group:wood","default:steel_ingot","group:wood" },
		{"group:wood","default:steel_ingot","group:wood" },
		{"group:wood","default:steel_ingot","group:wood" },
	},
})
minetest.register_craft({
	output = "castle_gates:portcullis_bars",
	recipe = {
		{"castle_gates:portcullis_bars_bottom"}
	},
})

minetest.register_node("castle_gates:portcullis_bars_bottom", {
	drawtype = "nodebox",
	description = S("Portcullis Bottom"),
	_doc_items_longdesc = castle_gates.doc.portcullis_bars_bottom_longdesc,
	_doc_items_usagehelp = castle_gates.doc.portcullis_bars_bottom_usagehelp,
	groups = {castle_gate = 1, choppy = 1, flow_through = 1},
	tiles = {
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		"default_wood.png^[transformR90",
		"default_wood.png^[transformR90",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		"castle_steel.png^(default_wood.png^[transformR90^[mask:castle_portcullis_mask.png)",
		},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.5, 0.125, 0.5, -0.25}, -- middle bar
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.25}, -- side bar
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.25}, -- side bar
			{-0.375, 0.1875, -0.4375, 0.375, 0.3125, -0.3125}, -- crosspiece
			{-0.375, -0.3125, -0.4375, 0.375, -0.1875, -0.3125}, -- crosspiece
			{-0.0625, -0.5, -0.4375, 0.0625, -0.625, -0.3125}, -- peg
			{0.4375, -0.5, -0.4375, 0.5, -0.625, -0.3125}, -- peg
			{-0.5, -0.5, -0.4375, -0.4375, -0.625, -0.3125}, -- peg
		}
	},
	_gate_edges = {bottom=true},
	on_rightclick = castle_gates.trigger_gate,
})
minetest.register_craft({
	output = "castle_gates:portcullis_bars_bottom",
	recipe = {
		{"castle_gates:portcullis_bars"}
	},
})
]]--
