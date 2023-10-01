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
minetest.register_node("cottages:wool_tent", {
		description = S("wool for tents"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_wool.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.50,  0.5, -0.5+1/16, 0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.50,  0.5, -0.5+1/16, 0.50},
			},
		},
		is_ground_content = false,
		on_place = minetest.rotate_node,
})
minetest.register_craft({
	output = "cottages:wool_tent 2",
	recipe = {
		{"farming:string", "farming:string"},
		{"",cottages.craftitem_stick}
	}
})
minetest.register_craft({
	output = "cottages:wool",
	recipe = {
		{"cottages:wool_tent", "cottages:wool_tent"}
	}
})
]]--
