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
xdecor.register("candle", {
	description = S("Candle"),
	light_source = 12,
	drawtype = "torchlike",
	inventory_image = "xdecor_candle_inv.png",
	wield_image = "xdecor_candle_wield.png",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = {dig_immediate = 3, attached_node = 1},
	tiles = {
		{
			name = "xdecor_candle_floor.png",
			animation = {type="vertical_frames", length = 1.5}
		},
		{
			name = "xdecor_candle_hanging.png",
			animation = {type="vertical_frames", length = 1.5}
		},
		{
			name = "xdecor_candle_wall.png",
			animation = {type="vertical_frames", length = 1.5}
		}
	},
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.25, -0.3, -0.25, 0.25, 0.5, 0.25},
		wall_bottom = {-0.25, -0.5, -0.25, 0.25, 0.1, 0.25},
		wall_side = {-0.5, -0.35, -0.15, -0.15, 0.4, 0.15}
	}
})
minetest.register_craft({
	output = "xdecor:candle",
	recipe = {
		{"default:torch"}
	}
})
]]--
