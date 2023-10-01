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
doors.register("door_bamboo", {
		tiles = {{ name = "doors_door_bamboo.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Bamboo Door",
		inventory_image = "doors_item_bamboo.png",
		groups = {door=1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"mapgen:bamboo", "mapgen:bamboo"},
			{"mapgen:bamboo", "mapgen:bamboo"},
			{"mapgen:bamboo", "mapgen:bamboo"},
		}
})
]]--
