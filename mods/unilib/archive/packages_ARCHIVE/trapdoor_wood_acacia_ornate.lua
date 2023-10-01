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
doors.register_trapdoor("moretrapdoors:acacia_trapdoor", {
	description = "Acacia Trapdoor",
	inventory_image = "acacia_trapdoor.png",
	wield_image = "acacia_trapdoor.png",
	tile_front = "acacia_trapdoor.png",
	tile_side = "acacia_trapdoor.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,

})
minetest.register_craft({
	output = "moretrapdoors:acacia_trapdoor 2",
	recipe = {
		{"default:acacia_wood", "default:acacia_wood", "default:acacia_wood"},
		{"default:acacia_wood", "default:acacia_tree", "default:acacia_wood"},
	}
})
]]--
