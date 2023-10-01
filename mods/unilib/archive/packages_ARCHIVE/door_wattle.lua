---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
doors.register("door_wattle", {
		tiles = {{ name = "earthbuild_door_wattle.png", backface_culling = true }},
		description = "Wattle Door",
		inventory_image = "earthbuild_door_wattle_inv.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1},
		recipe = {
			{"earthbuild:wattle", "earthbuild:wattle"},
			{"earthbuild:wattle", "earthbuild:wattle"},
			{"earthbuild:wattle", "earthbuild:wattle"},
		}
})
minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_wattle",
	burntime = 3,
})
]]--
