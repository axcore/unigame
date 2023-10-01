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
minetest.register_node("earthbuild:drystack", {
	description = "Drystack Wall",
	tiles = {"earthbuild_drystack.png"},
	groups = {cracky = 3, stone = 2, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_stone_defaults(),
})
stairs.register_stair_and_slab("drystack", "earthbuild:drystack",
		{cracky = 3, stone = 2, oddly_breakable_by_hand = 1},
		{"earthbuild_drystack.png"},
		"Drystack Stair",
		"Drystack Slab",
		default.node_sound_stone_defaults())
walls.register("earthbuild:drystack_wall", "Drystack Field Wall", "earthbuild_drystack.png",
		"earthbuild:drystack", default.node_sound_stone_defaults())
minetest.register_craft({
	output = 'earthbuild:drystack',
	recipe = {
		{'default:gravel', '', 'default:gravel'},
	}
})
minetest.register_craft({
	output = 'earthbuild:drystack',
	recipe = {
		{'default:flint', 'default:flint', 'default:flint'},
		{'default:flint', 'default:flint', 'default:flint'},
		{'default:flint', 'default:flint', 'default:flint'},
	}
})
minetest.register_craft({
	output = 'earthbuild:drystack',
	recipe = {
		{'earthbuild:drystack_wall'},
	}
})
]]--
