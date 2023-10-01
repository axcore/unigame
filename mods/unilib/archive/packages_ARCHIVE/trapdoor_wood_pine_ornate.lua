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
doors.register_trapdoor("moretrapdoors:pine_trapdoor", {
	description = "Pine Trapdoor",
	inventory_image = "pine_trapdoor.png",
	wield_image = "pine_trapdoor.png",
	tile_front = "pine_trapdoor.png",
	tile_side = "pine_trapdoor.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})
minetest.register_craft({
	output = "moretrapdoors:pine_trapdoor 2",
	recipe = {
		{"default:pine_wood", "default:pine_wood", "default:pine_wood"},
		{"default:pine_wood", "default:pine_tree", "default:pine_wood"},
	}
})
]]--
