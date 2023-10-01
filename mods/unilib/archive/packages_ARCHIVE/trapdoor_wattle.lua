---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    earthbuild
-- Code:    GPLv3
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
doors.register_trapdoor("earthbuild:trapdoor_wattle", {
	description = "Wattle Trapdoor",
	inventory_image = "earthbuild_trapdoor_wattle.png",
	wield_image = "earthbuild_trapdoor_wattle.png",
	tile_front = "earthbuild_trapdoor_wattle.png",
	tile_side = "earthbuild_trapdoor_wattle_side.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 1, door = 1},
})
minetest.register_craft({
	output = 'earthbuild:trapdoor_wattle 2',
	recipe = {
		{'earthbuild:wattle', 'earthbuild:wattle', ''},
		{'earthbuild:wattle', 'earthbuild:wattle', ''},
		{'', '', ''},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "trapdoor_wattle",
	burntime = 3,
})
]]--
