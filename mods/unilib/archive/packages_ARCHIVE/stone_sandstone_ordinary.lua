---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
--
-- From:    mtg_plus
-- Code:    MIT
-- Media:   CC-BY-SA 3.0/CC-BY 3.0/MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:sandstone", {
	description = S("Sandstone"),
	tiles = {"default_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:sandstone",
	recipe = {
		{"default:sand", "default:sand"},
		{"default:sand", "default:sand"},
	}
})
minetest.register_craft({
	output = "default:sand 4",
	recipe = {
		{"default:sandstone"},
	}
})
my_register_stair_and_slab(
	"sandstone",
	"default:sandstone",
	{crumbly = 1, cracky = 3},
	{"default_sandstone.png"},
	"Sandstone Stair",
	"Sandstone Slab",
	default.node_sound_stone_defaults(),
	true
)
local nodes = {
	["trap_sandstone"] = {
		description = S("Trap Sandstone"),
		drawtype = "glasslike_framed",
		tiles = {"default_sandstone.png^moreblocks_trap_box.png"},
		walkable = false,
		groups = {crumbly = 1, cracky = 3},
		paramtype = "light",
		is_ground_content = false,
		sounds = sound_stone,
		no_stairs = true,
	},
}
minetest.register_craft({
	output = "moreblocks:trap_sandstone",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:sandstone"},
})

minetest.register_node("default:sandstone_block", {
	description = S("Sandstone Block"),
	tiles = {"default_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:sandstone_block 9",
	recipe = {
		{"default:sandstone", "default:sandstone", "default:sandstone"},
		{"default:sandstone", "default:sandstone", "default:sandstone"},
		{"default:sandstone", "default:sandstone", "default:sandstone"},
	}
})
my_register_stair_and_slab(
	"sandstone_block",
	"default:sandstone_block",
	{cracky = 2},
	{"default_sandstone_block.png"},
	"Sandstone Block Stair",
	"Sandstone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

minetest.register_node("default:sandstonebrick", {
	description = S("Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:sandstonebrick 4",
	recipe = {
		{"default:sandstone", "default:sandstone"},
		{"default:sandstone", "default:sandstone"},
	}
})
my_register_stair_and_slab(
	"sandstonebrick",
	"default:sandstonebrick",
	{cracky = 2},
	{"default_sandstone_brick.png"},
	"Sandstone Brick Stair",
	"Sandstone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)
]]--

--[[
minetest.register_node("mtg_plus:sandstone_cobble", {
	description = S("Cobbled Sandstone"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_sandstone_cobble.png"},
	groups = {cracky = 3, },
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "mtg_plus:sandstone_cobble 2",
	recipe = { { "default:sandstone", "default:sandstone" } },
})
minetest.register_craft({
	type = "cooking",
	output = "default:sandstone",
	recipe = "mtg_plus:sandstone_cobble",
})
simple_stair_slab("sandstone_cobble", S("Cobbled Sandstone Stair"), S("Cobbled Sandstone Slab"))
walls.register("mtg_plus:wall_sandstone_cobble", S("Cobbled Sandstone Wall"), "mtg_plus_sandstone_cobble.png", "mtg_plus:sandstone_cobble", default.node_sound_stone_defaults())
]]--
