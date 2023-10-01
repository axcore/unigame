---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/clementinetree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("doors") ~= nil then
	doors.register("door_clementinetree_wood", {
			tiles = {{ name = "clementinetree_door_wood.png", backface_culling = true }},
			description = S("Clementine Wood Door"),
			inventory_image = "clementinetree_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"clementinetree:wood", "clementinetree:wood"},
				{"clementinetree:wood", "clementinetree:wood"},
				{"clementinetree:wood", "clementinetree:wood"},
			}
	})
end
]]--
