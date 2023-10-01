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
doors.register("pine_door", {
    tiles = {{ name = "doors_pine_door.png", backface_culling = true }},
    description = "Pine Door",
    inventory_image = "doors_item_pine.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"default:pine_wood", "default:pine_wood"},
		{"default:pine_tree", "default:pine_tree"},
		{"default:pine_wood", "default:pine_wood"},
	} 
})
]]--
