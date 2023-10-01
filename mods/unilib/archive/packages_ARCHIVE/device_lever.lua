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
xdecor.register("lever_off", {
	description = S("Lever"),
	tiles = {"xdecor_lever_off.png"},
	use_texture_alpha = ALPHA_OPAQUE,
	drawtype = "nodebox",
	node_box = xdecor.pixelbox(16, {{2, 1, 15, 12, 14, 1}}),
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_stone_defaults(),
	sunlight_propagates = true,
	on_rotate = screwdriver.rotate_simple,

	on_rightclick = function(pos, node, clicker, itemstack)
		if not doors.get then return itemstack end
		local minp = {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2}
		local maxp = {x = pos.x + 2, y = pos.y + 1, z = pos.z + 2}
		local doors = minetest.find_nodes_in_area(minp, maxp, "group:door")

		for i = 1, #doors do
			door_toggle(pos, doors[i], clicker)
		end

		return itemstack
	end
})
minetest.register_craft({
	output = "xdecor:lever_off",
	recipe = {
		{"group:stick"},
		{"group:stone"}
	}
})

xdecor.register("lever_on", {
	tiles = {"xdecor_lever_on.png"},
	use_texture_alpha = ALPHA_OPAQUE,
	drawtype = "nodebox",
	node_box = xdecor.pixelbox(16, {{2, 1, 15, 12, 14, 1}}),
	groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	sunlight_propagates = true,
	on_rotate = screwdriver.rotate_simple,
	drop = "xdecor:lever_off"
})
]]--
