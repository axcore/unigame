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
minetest.register_node('earthbuild:turf', {
	description = 'Turf Wall',
	drawtype = "normal",
	tiles = { "default_grass.png",
						"earthbuild_compacted_dirt.png",
					 	"earthbuild_turf.png",
						"earthbuild_turf.png",
						"earthbuild_turf.png",
						"earthbuild_turf.png"},
	paramtype = "light",
	--drop = "default:dirt",
	groups = {crumbly = 2, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})
stairs.register_stair_and_slab("turf", "earthbuild:turf",
		{crumbly = 2, falling_node = 1},
		{ "default_grass.png",
							"earthbuild_compacted_dirt.png",
							"earthbuild_turf.png",
							"earthbuild_turf.png",
							"earthbuild_turf.png",
							"earthbuild_turf.png"},
		"Turf Stair",
		"Turf Slab",
		default.node_sound_dirt_defaults())
]]--
