---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/oak
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("doors") ~= nil then
	doors.register("door_oak_wood", {
			tiles = {{ name = "oak_door_wood.png", backface_culling = true }},
			description = S("Oak Wood Door"),
			inventory_image = "oak_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"oak:wood", "oak:wood"},
				{"oak:wood", "oak:wood"},
				{"oak:wood", "oak:wood"},
			}
	})
end
]]--
