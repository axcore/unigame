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
xdecor.register("cushion", {
	description = S("Cushion"),
	tiles = {"xdecor_cushion.png"},
	groups = {snappy = 3, flammable = 3, fall_damage_add_percent = -50},
	on_place = minetest.rotate_node,
	node_box = xdecor.nodebox.slab_y(0.5),
	can_dig = xdecor.sit_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y + 0  -- Sitting position
		xdecor.sit(pos, node, clicker, pointed_thing)
		return itemstack
	end
})
minetest.register_craft({
	output = "xdecor:cushion 3",
	recipe = {
		{"wool:red", "wool:red", "wool:red"}
	}
})

xdecor.register("cushion_block", {
	description = S("Cushion Block"),
	tiles = {"xdecor_cushion.png"},
	groups = {snappy = 3, flammable = 3, fall_damage_add_percent = -75, not_in_creative_inventory = 1}
})
minetest.register_craft({
	output = "xdecor:cushion_block",
	recipe = {
		{"xdecor:cushion"},
		{"xdecor:cushion"}
	}
})
]]--
