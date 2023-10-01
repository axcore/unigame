---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/palm
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if minetest.get_modpath("doors") ~= nil then
	doors.register("door_palm", {
		tiles = {{ name = "palm_door_wood.png", backface_culling = true }},
		description = S("Palm Door"),
		inventory_image = "palm_door_wood_inv.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"palm:wood", "palm:wood"},
			{"palm:leaves", "palm:leaves"},
			{"palm:wood", "palm:wood"},
		}
	})
end
]]--
