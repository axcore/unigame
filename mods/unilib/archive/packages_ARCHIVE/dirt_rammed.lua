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
minetest.register_node('earthbuild:rammed_earth', {
	description = 'Rammed Earth',
	drawtype = "normal",
	tiles = {
		"earthbuild_rammed_earth.png",
		"earthbuild_rammed_earth_side.png",
		"earthbuild_rammed_earth_side.png",
		"earthbuild_rammed_earth_side.png",
		"earthbuild_rammed_earth_side.png",
		"earthbuild_rammed_earth_side.png"
},
	paramtype = "light",
	--drop = "default:dirt",
	groups = {crumbly = 1, cracky = 3, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:rammed_earth 1',
	recipe = {
		{'default:dirt'},
		{'default:dirt'},
		{'default:dirt'},
	}
})
minetest.register_craft({
	output = 'earthbuild:rammed_earth 1',
	recipe = {
		{'default:dry_dirt'},
		{'default:dry_dirt'},
		{'default:dry_dirt'},
	}
})
stairs.register_stair_and_slab("rammed_earth", "earthbuild:rammed_earth",
		{crumbly = 1, cracky = 3, falling_node = 1},
		{"earthbuild_rammed_earth.png"},
		"Rammed Earth Stair",
		"Rammed Earth Slab",
		default.node_sound_dirt_defaults())
]]--
