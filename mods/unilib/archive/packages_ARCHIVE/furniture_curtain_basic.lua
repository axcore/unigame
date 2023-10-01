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
local curtain_colors = {
	red = S("Red Curtain"),
}

for c, desc in pairs(curtain_colors) do
	xdecor.register("curtain_" .. c, {
		description = desc,
		walkable = false,
		tiles = {"wool_white.png"},
		color = c,
		inventory_image = "wool_white.png^[colorize:" .. c ..
			":170^xdecor_curtain_open_overlay.png^[makealpha:255,126,126",
		wield_image = "wool_white.png^[colorize:" .. c .. ":170",
		drawtype = "signlike",
		paramtype2 = "colorwallmounted",
		groups = {dig_immediate = 3, flammable = 3},
		selection_box = {type = "wallmounted"},
		on_rightclick = function(pos, node, _, itemstack)
			minetest.set_node(pos, {name = "xdecor:curtain_open_" .. c, param2 = node.param2})
			return itemstack
		end
	})

	xdecor.register("curtain_open_" .. c, {
		tiles = {"wool_white.png^xdecor_curtain_open_overlay.png^[makealpha:255,126,126"},
		color = c,
		drawtype = "signlike",
		paramtype2 = "colorwallmounted",
		walkable = false,
		groups = {dig_immediate = 3, flammable = 3, not_in_creative_inventory = 1},
		selection_box = {type="wallmounted"},
		drop = "xdecor:curtain_" .. c,
		on_rightclick = function(pos, node, _, itemstack)
			minetest.set_node(pos, {name="xdecor:curtain_" .. c, param2 = node.param2})
			return itemstack
		end
	})

	minetest.register_craft({
		output = "xdecor:curtain_" .. c .. " 4",
		recipe = {
			{"", "wool:" .. c, ""},
			{"", "wool:" .. c, ""}
		}
	})
end
]]--
