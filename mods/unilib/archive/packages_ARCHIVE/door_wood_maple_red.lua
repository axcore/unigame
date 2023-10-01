---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/maple
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("doors") ~= nil then
	doors.register("door_maple_wood", {
			tiles = {{ name = "maple_door_wood.png", backface_culling = true }},
			description = S("Maple Wood Door"),
			inventory_image = "maple_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"maple:wood", "maple:wood"},
				{"maple:wood", "maple:wood"},
				{"maple:wood", "maple:wood"},
			}
	})
end
]]--
