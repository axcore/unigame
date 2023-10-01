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
minetest.register_node("cottages:glass_pane", {
		description = S("simple glass pane (centered)"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_glass_pane.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.05,  0.5, 0.5,  0.05},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.05,  0.5, 0.5,  0.05},
			},
		},
		is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:glass_pane 4",
	recipe = {
		{cottages.craftitem_stick, cottages.craftitem_stick, cottages.craftitem_stick },
		{cottages.craftitem_stick, cottages.craftitem_glass, cottages.craftitem_stick },
		{cottages.craftitem_stick, cottages.craftitem_stick, cottages.craftitem_stick }
	}
})
minetest.register_craft({
	output = "cottages:glass_pane",
	recipe = {
		{"cottages:glass_pane_side"},
	}
})

minetest.register_node("cottages:glass_pane_side", {
		description = S("simple glass pane"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_glass_pane.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.40,  0.5, 0.5, -0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.40,  0.5, 0.5, -0.50},
			},
		},
		is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:glass_pane_side",
	recipe = {
		{"cottages:glass_pane"},
	}
})
]]--
