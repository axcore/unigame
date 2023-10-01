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
minetest.register_node('earthbuild:turf_and_drystack', {
	description = 'Turf and Drystack Wall',
	drawtype = "normal",
	tiles = { "default_grass.png",
						"earthbuild_compacted_dirt.png",
					 	"earthbuild_turf_and_drystack.png",
						"earthbuild_turf_and_drystack.png",
						"earthbuild_turf_and_drystack.png",
						"earthbuild_turf_and_drystack.png"},
	paramtype = "light",
	groups = {cracky = 3, crumbly = 1, oddly_breakable_by_hand = 1, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:turf_and_drystack 2',
	recipe = {
		{'earthbuild:turf'},
		{'earthbuild:drystack'},
	}
})
]]--
