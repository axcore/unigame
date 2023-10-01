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
minetest.register_node('earthbuild:thatch', {
	description = 'Thatch',
	drawtype = "normal",
	tiles = {"earthbuild_thatch.png"},
	paramtype = "light",
	drop = "earthbuild:thatch",
	groups = {snappy=3, flammable=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_craft({
	output = 'earthbuild:thatch 6',
	recipe = {
		{'group:leaves', 'group:leaves', 'group:leaves'},
		{'group:leaves', 'group:leaves', 'group:leaves'},
		{'group:leaves', 'group:leaves', 'group:leaves'},
	}
})
minetest.register_craft({
	output = 'earthbuild:thatch 6',
	recipe = {
		{'group:grass', 'group:grass', 'group:grass'},
		{'group:grass', 'group:grass', 'group:grass'},
		{'group:grass', 'group:grass', 'group:grass'},
	}
})
minetest.register_craft({
	output = 'earthbuild:thatch 6',
	recipe = {
		{'group:dry_grass', 'group:dry_grass', 'group:dry_grass'},
		{'group:dry_grass', 'group:dry_grass', 'group:dry_grass'},
		{'group:dry_grass', 'group:dry_grass', 'group:dry_grass'},
	}
})
minetest.register_craft({
	output = 'earthbuild:thatch 6',
	recipe = {
		{'default:junglegrass', 'default:junglegrass', 'default:junglegrass'},
		{'default:junglegrass', 'default:junglegrass', 'default:junglegrass'},
		{'default:junglegrass', 'default:junglegrass', 'default:junglegrass'},
	}
})
minetest.register_craft({
	output = 'earthbuild:thatch 6',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "earthbuild:thatch",
	burntime = 9,
})
stairs.register_stair_and_slab("thatch", "earthbuild:thatch",
		{snappy=3, flammable=1},
		{"earthbuild_thatch.png"},
		"Thatch Stair",
		"Thatch Slab",
		default.node_sound_leaves_defaults())
]]--
