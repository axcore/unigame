---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/birch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("doors") ~= nil then
	doors.register("door_birch_wood", {
			tiles = {{ name = "birch_door_wood.png", backface_culling = true }},
			description = S("Birch Wood Door"),
			inventory_image = "birch_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"birch:wood", "birch:wood"},
				{"birch:wood", "birch:wood"},
				{"birch:wood", "birch:wood"},
			}
	})
end
]]--
