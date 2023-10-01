---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cottages
-- Code:    GPLv3
-- Media:   CC/CC-by-SA/WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("cottages:gate_closed", {
		description = S("closed fence gate"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {cottages.texture_furniture},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.25, -0.02,  0.85, -0.05,  0.02},
				{ -0.85,  0.15, -0.02,  0.85,  0.35,  0.02},

				{ -0.80, -0.05, -0.02, -0.60,  0.15,  0.02},
				{  0.60, -0.05, -0.02,  0.80,  0.15,  0.02},
				{ -0.15, -0.05, -0.02,  0.15,  0.15,  0.02},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.25, -0.1,  0.85,  0.35,  0.1},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:gate_open", param2 = node.param2})
                end,
		is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:gate_closed",
	recipe = {
		{cottages.craftitem_stick, cottages.craftitem_stick, cottages.craftitem_wood },
	}
})
-- transform open and closed versions into into another for convenience
minetest.register_craft({
	output = "cottages:gate_closed",
	recipe = {
		{"cottages:gate_open" },
	}
})
minetest.register_craft({
	output = "cottages:gate_open",
	recipe = {
		{"cottages:gate_closed"},
	}
})

minetest.register_node("cottages:gate_open", {
		description = S("opened fence gate"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {cottages.texture_furniture},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = "cottages:gate_closed",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.5, -0.25,  0.85, -0.46, -0.05},
				{ -0.85, -0.5,  0.15,  0.85, -0.46,  0.35},

				{ -0.80, -0.5, -0.05, -0.60, -0.46,  0.15},
				{  0.60, -0.5, -0.05,  0.80, -0.46,  0.15},
				{ -0.15, -0.5, -0.05,  0.15, -0.46,  0.15},

			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.85, -0.5, -0.25, 0.85, -0.3, 0.35},
			},
		},
                on_rightclick = function(pos, node, puncher)
                    minetest.swap_node(pos, {name = "cottages:gate_closed", param2 = node.param2})
                end,
		is_ground_content = false,
		drop = "cottages:gate_closed",
})
]]--
