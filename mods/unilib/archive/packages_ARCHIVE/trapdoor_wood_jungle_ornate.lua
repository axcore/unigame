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
doors.register_trapdoor("moretrapdoors:jungle_trapdoor", {
	description = "Jungle Trapdoor",
	inventory_image = "jungle_trapdoor.png",
	wield_image = "jungle_trapdoor.png",
	tile_front = "jungle_trapdoor.png",
	tile_side = "jungle_trapdoor_side.png",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	gain_open = 0.06,
	gain_close = 0.13,
})
minetest.register_craft({
	output = "moretrapdoors:jungle_trapdoor 2",
	recipe = {
		{"default:junglewood", "default:junglewood", "default:junglewood"},
		{"default:junglewood", "default:jungletree", "default:junglewood"},
	}
})
]]--
