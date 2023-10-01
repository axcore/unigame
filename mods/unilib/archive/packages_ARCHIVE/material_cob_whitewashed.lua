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
minetest.register_node('earthbuild:whitewashed_earth', {
	description = 'Whitewashed Earth',
	drawtype = "normal",
	tiles = {"earthbuild_whitewashed_earth.png"},
	paramtype = "light",
	groups = {crumbly = 1, cracky = 2, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:whitewashed_earth',
	recipe = {
		{'earthbuild:cob', 'earthbuild:whitewash'},
	}
})
minetest.register_craft({
	output = 'earthbuild:whitewashed_earth',
	recipe = {
		{'earthbuild:rammed_earth', 'earthbuild:whitewash'},
	}
})
stairs.register_stair_and_slab("whitewashed_earth", "earthbuild:whitewashed_earth",
		{crumbly = 1, cracky = 2, falling_node = 1},
		{"earthbuild_whitewashed_earth.png"},
		"Whitewashed Earth Stair",
		"Whitewashed Earth Slab",
		default.node_sound_dirt_defaults())
        
minetest.register_node('earthbuild:whitewashed_mud_brick', {
	description = 'Whitewashed Mud Brick',
	drawtype = "normal",
	tiles = {"earthbuild_whitewashed_earth.png"},
	paramtype = "light",
	groups = {crumbly = 1, cracky = 2},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:whitewashed_mud_brick',
	recipe = {
		{'earthbuild:mud_brick', 'earthbuild:whitewash'},
	}
})
stairs.register_stair_and_slab("whitewashed_mud_brick", "earthbuild:whitewashed_mud_brick",
		{crumbly = 1, cracky = 2},
		{"earthbuild_whitewashed_earth.png"},
		"Whitewashed Earth Stair",
		"Whitewashed Earth Slab",
		default.node_sound_dirt_defaults())
]]--
