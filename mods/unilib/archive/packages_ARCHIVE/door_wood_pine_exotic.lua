---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
doors.register("door_pine_wood", {
		tiles = {{ name = "doors_pine_wood_door.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Pine Wood Door",
		inventory_image = "doors_pine_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:pine_wood", "default:pine_wood"},
			{"default:pine_wood", "default:pine_wood"},
			{"default:pine_wood", "default:pine_wood"},
		}
})
]]--
