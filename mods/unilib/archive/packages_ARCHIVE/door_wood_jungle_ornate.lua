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
doors.register("jungle_door", {
    tiles = {{ name = "doors_jungle_door.png", backface_culling = true }},
    description = "Jungle Door",
    inventory_image = "doors_item_jungle.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"default:junglewood", "default:junglewood"},
		{"default:jungletree", "default:jungletree"},
		{"default:junglewood", "default:junglewood"},
	} 
})
]]--
