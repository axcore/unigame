---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    doors
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
doors.register("door_wood", {
		tiles = {{ name = "doors_door_wood.png", backface_culling = true }},
		description = S("Wooden Door"),
		inventory_image = "doors_item_wood.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		gain_open = 0.06,
		gain_close = 0.13,
		recipe = {
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
		}
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_wood",
	burntime = 14,
})
]]--
