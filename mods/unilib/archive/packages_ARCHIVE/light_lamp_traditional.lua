---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    xdecor
-- Code:    BSD
-- Media:   WTFPL/CC BY-SA/CC BY 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
xdecor.register("lantern", {
	description = S("Lantern"),
	light_source = 13,
	drawtype = "plantlike",
	inventory_image = "xdecor_lantern_inv.png",
	wield_image = "xdecor_lantern_inv.png",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = {snappy = 3, attached_node = 1},
	tiles = {
		{
			name = "xdecor_lantern.png",
			animation = {type="vertical_frames", length = 1.5}
		}
	},
	selection_box = xdecor.pixelbox(16, {{4, 0, 4, 8, 16, 8}})
})
minetest.register_craft({
	output = "xdecor:lantern",
	recipe = {
		{"default:iron_lump"},
		{"default:torch"},
		{"default:iron_lump"}
	}
})
]]--
