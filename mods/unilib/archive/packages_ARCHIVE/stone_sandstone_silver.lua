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
minetest.register_node("default:silver_sandstone", {
	description = S("Silver Sandstone"),
	tiles = {"default_silver_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:silver_sandstone",
	recipe = {
		{"default:silver_sand", "default:silver_sand"},
		{"default:silver_sand", "default:silver_sand"},
	}
})
minetest.register_craft({
	output = "default:silver_sand 4",
	recipe = {
		{"default:silver_sandstone"},
	}
})
my_register_stair_and_slab(
	"silver_sandstone",
	"default:silver_sandstone",
	{crumbly = 1, cracky = 3},
	{"default_silver_sandstone.png"},
	"Silver Sandstone Stair",
	"Silver Sandstone Slab",
	default.node_sound_stone_defaults(),
	true
)

minetest.register_node("default:silver_sandstone_block", {
	description = S("Silver Sandstone Block"),
	tiles = {"default_silver_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:silver_sandstone_block 9",
	recipe = {
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
	}
})
my_register_stair_and_slab(
	"silver_sandstone_block",
	"default:silver_sandstone_block",
	{cracky = 2},
	{"default_silver_sandstone_block.png"},
	"Silver Sandstone Block Stair",
	"Silver Sandstone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

minetest.register_node("default:silver_sandstone_brick", {
	description = S("Silver Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_silver_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:silver_sandstone_brick 4",
	recipe = {
		{"default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone"},
	}
})
my_register_stair_and_slab(
	"silver_sandstone_brick",
	"default:silver_sandstone_brick",
	{cracky = 2},
	{"default_silver_sandstone_brick.png"},
	"Silver Sandstone Brick Stair",
	"Silver Sandstone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)
]]--

--[[
minetest.register_node("mtg_plus:silver_sandstone_cobble", {
	description = S("Cobbled Silver Sandstone"),
	_doc_items_longdesc = build,
	tiles = {"mtg_plus_silver_sandstone_cobble.png"},
	groups = {cracky = 3, },
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "mtg_plus:silver_sandstone_cobble 2",
	recipe = { { "default:silver_sandstone", "default:silver_sandstone" } },
})

minetest.register_craft({
	type = "cooking",
	output = "default:silver_sandstone",
	recipe = "mtg_plus:silver_sandstone_cobble",
})
simple_stair_slab("silver_sandstone_cobble", S("Cobbled Silver Sandstone Stair"), S("Cobbled Silver Sandstone Slab"))
walls.register("mtg_plus:wall_silver_sandstone_cobble", S("Cobbled Silver Sandstone Wall"), "mtg_plus_silver_sandstone_cobble.png", "mtg_plus:silver_sandstone_cobble", default.node_sound_stone_defaults())
]]--
