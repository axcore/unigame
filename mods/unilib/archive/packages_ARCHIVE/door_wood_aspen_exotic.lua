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
doors.register("door_aspen_wood", {
		tiles = {{ name = "doors_aspen_wood_door.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Aspen Wood Door",
		inventory_image = "doors_aspen_wood_door_item.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:aspen_wood", "default:aspen_wood"},
			{"default:aspen_wood", "default:aspen_wood"},
			{"default:aspen_wood", "default:aspen_wood"},
		}
})
]]--
