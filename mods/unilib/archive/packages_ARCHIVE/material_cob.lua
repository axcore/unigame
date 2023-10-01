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
minetest.register_node('earthbuild:cob', {
	description = 'Cob',
	drawtype = "normal",
	tiles = {"earthbuild_cob.png"},
	paramtype = "light",
	--drop = "default:dirt",
	groups = {crumbly = 2, cracky = 3, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:cob 2',
	recipe = {
		{'default:dirt', '', 'default:dirt'},
		{'', 'group:grass', ''},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'earthbuild:cob 2',
	recipe = {
		{'default:dirt', '', 'default:dirt'},
		{'', 'group:dry_grass', ''},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'earthbuild:cob 2',
	recipe = {
		{'default:dirt', '', 'default:dirt'},
		{'', 'default:junglegrass', ''},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'earthbuild:cob 2',
	recipe = {
		{'default:dirt', '', 'default:dirt'},
		{'', 'default:dry_shrub', ''},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'earthbuild:cob 2',
	recipe = {
		{'default:dirt', '', 'default:dirt'},
		{'', 'default:papyrus', ''},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'earthbuild:cob 2',
	recipe = {
		{'default:dirt', '', 'default:dirt'},
		{'', 'farming:wheat', ''},
		{'', '', ''},
	}
})
minetest.register_craft({
	output = 'earthbuild:cob 2',
	recipe = {
		{'default:dirt', '', 'default:dirt'},
		{'', 'group:leaves', ''},
		{'', '', ''},
	}
})
stairs.register_stair_and_slab("cob", "earthbuild:cob",
		{crumbly = 2, cracky = 3, falling_node = 1},
		{"earthbuild_cob.png"},
		"Cob Stair",
		"Cob Slab",
		default.node_sound_dirt_defaults())
        
minetest.register_node('earthbuild:mud_brick', {
	description = 'Mud Brick',
	drawtype = "normal",
	tiles = {"earthbuild_mud_brick.png"},
	paramtype = "light",
	groups = {crumbly = 2, cracky = 3},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:mud_brick',
	recipe = {{'earthbuild:cob'}}
})
stairs.register_stair_and_slab("mud_brick", "earthbuild:mud_brick",
		{crumbly = 2, cracky = 3},
		{"earthbuild_mud_brick.png"},
		"Mud Brick Stair",
		"Mud Brick Slab",
		default.node_sound_dirt_defaults())
]]--
