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
doors.register_trapdoor("moretrapdoors:wood_trapdoor", {
	description = "Wooden Trapdoor",
	inventory_image = "wood_trapdoor.png",
	wield_image = "wood_trapdoor.png",
	tile_front = "wood_trapdoor.png",
	tile_side = "wood_trapdoor.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,
})
minetest.register_craft({
	output = "moretrapdoors:wood_trapdoor 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:tree", "default:wood"},
	}
})
]]--
