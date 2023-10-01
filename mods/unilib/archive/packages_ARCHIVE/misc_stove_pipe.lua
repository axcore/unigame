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
-- so that the smoke from a furnace can get out of a building
minetest.register_node("cottages:stovepipe", {
		description = S("stovepipe"),
		drawtype = "nodebox",
		tiles = {"cottages_steel_block.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{  0.20, -0.5, 0.20,  0.45, 0.5,  0.45},
			},
		},
		is_ground_content = false,
})
minetest.register_craft({
	output = "cottages:stovepipe 2",
	recipe = {
		{cottages.craftitem_steel, '', cottages.craftitem_steel},
	}
})
]]--
