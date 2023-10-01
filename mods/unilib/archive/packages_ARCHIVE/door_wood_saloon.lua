---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrapdoors
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
doors.register("western_door", {
    tiles = {{ name = "doors_western_door.png", backface_culling = false }},
    description = "Western Door",
    inventory_image = "doors_item_western.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"default:wood", "default:wood"},
		{"default:wood", "default:wood"},
	}
})
]]--
