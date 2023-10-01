---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/larch
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("doors") ~= nil then
	doors.register("door_larch_wood", {
			tiles = {{ name = "larch_door_wood.png", backface_culling = true }},
			description = S("Larch Wood Door"),
			inventory_image = "larch_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"larch:wood", "larch:wood"},
				{"larch:wood", "larch:wood"},
				{"larch:wood", "larch:wood"},
			}
	})
end
]]--
