---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/chestnuttree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("doors") ~= nil then
	doors.register("door_chestnut_wood", {
			tiles = {{ name = "chesnuttree_door_wood.png", backface_culling = true }},
			description = S("Chestnut Wood Door"),
			inventory_image = "chestnuttree_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"chestnuttree:wood", "chestnuttree:wood"},
				{"chestnuttree:wood", "chestnuttree:wood"},
				{"chestnuttree:wood", "chestnuttree:wood"},
			}
	})
end
]]--
