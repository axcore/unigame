---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"default_desert_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:desert_sandstone",
	recipe = {
		{"default:desert_sand", "default:desert_sand"},
		{"default:desert_sand", "default:desert_sand"},
	}
})
minetest.register_craft({
	output = "default:desert_sand 4",
	recipe = {
		{"default:desert_sandstone"},
	}
})
my_register_stair_and_slab(
	"desert_sandstone",
	"default:desert_sandstone",
	{crumbly = 1, cracky = 3},
	{"default_desert_sandstone.png"},
	"Desert Sandstone Stair",
	"Desert Sandstone Slab",
	default.node_sound_stone_defaults(),
	true
)

minetest.register_node("default:desert_sandstone_block", {
	description = S("Desert Sandstone Block"),
	tiles = {"default_desert_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:desert_sandstone_block 9",
	recipe = {
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
	}
})
my_register_stair_and_slab(
	"desert_sandstone_block",
	"default:desert_sandstone_block",
	{cracky = 2},
	{"default_desert_sandstone_block.png"},
	"Desert Sandstone Block Stair",
	"Desert Sandstone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

minetest.register_node("default:desert_sandstone_brick", {
	description = S("Desert Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_desert_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:desert_sandstone_brick 4",
	recipe = {
		{"default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone"},
	}
})
my_register_stair_and_slab(
	"desert_sandstone_brick",
	"default:desert_sandstone_brick",
	{cracky = 2},
	{"default_desert_sandstone_brick.png"},
	"Desert Sandstone Brick Stair",
	"Desert Sandstone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)
]]--

--[[
minetest.register_node("mtg_plus:desert_sandstone_cobble", {
	description = S("Cobbled Desert Sandstone"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_desert_sandstone_cobble.png"},
	groups = {cracky = 3, },
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "mtg_plus:desert_sandstone_cobble 2",
	recipe = { { "default:desert_sandstone", "default:desert_sandstone" } },
})

minetest.register_craft({
	type = "cooking",
	output = "default:desert_sandstone",
	recipe = "mtg_plus:desert_sandstone_cobble",
})
simple_stair_slab("desert_sandstone_cobble", S("Cobbled Desert Sandstone Stair"), S("Cobbled Desert Sandstone Slab"))
walls.register("mtg_plus:wall_desert_sandstone_cobble", S("Cobbled Desert Sandstone Wall"), "mtg_plus_desert_sandstone_cobble.png", "mtg_plus:desert_sandstone_cobble", default.node_sound_stone_defaults())
]]--
