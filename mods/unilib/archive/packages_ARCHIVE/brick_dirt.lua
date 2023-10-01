---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("mtg_plus:dirtbrick", {
	description = S("Soft Dirt Brick"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_dirt_brick.png"},
	is_ground_content = false,
	groups = { crumbly = 2, soil = 1 },
	sounds = default.node_sound_dirt_defaults(),
	drop = "default:dirt",
})
minetest.register_craft({
	output = "mtg_plus:dirtbrick 4",
	recipe = { { "default:dirt", "default:dirt", },
	{ "default:dirt", "default:dirt", }, },
})

minetest.register_node("mtg_plus:harddirtbrick", {
	description = S("Hardened Dirt Brick"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_dirt_brick_hard.png"},
	is_ground_content = false,
	groups = { crumbly = 1, level = 1, soil = 1 },
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "mtg_plus:harddirtbrick",
	recipe = "mtg_plus:dirtbrick",
	cooktime = 5,
})
simple_stair_slab("harddirtbrick", S("Hardened Dirt Brick Stair"), S("Hardened Dirt Brick Slab"))
]]--
