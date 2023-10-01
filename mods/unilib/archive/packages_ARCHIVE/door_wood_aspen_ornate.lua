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
doors.register("aspen_doors", {
    tiles = {{ name = "doors_aspen_door.png", backface_culling = true }},
    description = "Aspen Door",
    inventory_image = "doors_item_aspen.png",
    groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    gain_open = 0.06,
    gain_close = 0.13,
	recipe = {
		{"default:aspen_wood", "default:aspen_wood"},
		{"default:aspen_tree", "default:aspen_tree"},
		{"default:aspen_wood", "default:aspen_wood"},
	} 
})

]]--
