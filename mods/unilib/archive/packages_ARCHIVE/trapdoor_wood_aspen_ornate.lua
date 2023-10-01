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
doors.register_trapdoor("moretrapdoors:aspen_trapdoor", {
	description = "Aspen Trapdoor",
	inventory_image = "aspen_trapdoor.png",
	wield_image = "aspen_trapdoor.png",
	tile_front = "aspen_trapdoor.png",
	tile_side = "aspen_trapdoor.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,
})
minetest.register_craft({
	output = "moretrapdoors:aspen_trapdoor 2",
	recipe = {
		{"default:aspen_wood", "default:aspen_wood", "default:aspen_wood"},
		{"default:aspen_wood", "default:aspen_tree", "default:aspen_wood"},
	}
})
]]--
