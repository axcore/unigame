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
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"default_desert_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "default:desert_cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
my_register_stair_and_slab(
	"desert_stone",
	"default:desert_stone",
	{cracky = 3},
	{"default_desert_stone.png"},
	"Desert Stone Stair",
	"Desert Stone Slab",
	default.node_sound_stone_defaults(),
	true
)
local nodes = {
	["trap_desert_stone"] = {
		description = S("Trap Desert Stone"),
		drawtype = "glasslike_framed",
		tiles = {"default_desert_stone.png^moreblocks_trap_box.png"},
		walkable = false,
		groups = {cracky = 3},
		paramtype = "light",
		is_ground_content = false,
		sounds = sound_stone,
		no_stairs = true,
	},
}
minetest.register_craft({
	output = "moreblocks:trap_desert_stone",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:desert_stone"},
})

minetest.register_node("default:desert_stone_block", {
	description = S("Desert Stone Block"),
	tiles = {"default_desert_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:desert_stone_block 9",
	recipe = {
		{"default:desert_stone", "default:desert_stone", "default:desert_stone"},
		{"default:desert_stone", "default:desert_stone", "default:desert_stone"},
		{"default:desert_stone", "default:desert_stone", "default:desert_stone"},
	}
})
my_register_stair_and_slab(
	"desert_stone_block",
	"default:desert_stone_block",
	{cracky = 2},
	{"default_desert_stone_block.png"},
	"Desert Stone Block Stair",
	"Desert Stone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

minetest.register_node("default:desert_stonebrick", {
	description = S("Desert Stone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_desert_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "default:desert_stonebrick 4",
	recipe = {
		{"default:desert_stone", "default:desert_stone"},
		{"default:desert_stone", "default:desert_stone"},
	}
})
my_register_stair_and_slab(
	"desert_stonebrick",
	"default:desert_stonebrick",
	{cracky = 2},
	{"default_desert_stone_brick.png"},
	"Desert Stone Brick Stair",
	"Desert Stone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

minetest.register_node("default:desert_cobble", {
	description = S("Desert Cobblestone"),
	tiles = {"default_desert_cobble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "default:desert_cobble",
})
my_register_stair_and_slab(
	"desert_cobble",
	"default:desert_cobble",
	{cracky = 3},
	{"default_desert_cobble.png"},
	"Desert Cobblestone Stair",
	"Desert Cobblestone Slab",
	default.node_sound_stone_defaults(),
	true
)
walls.register("walls:desertcobble", S("Desert Cobblestone Wall"), {"default_desert_cobble.png"},
		"default:desert_cobble", default.node_sound_stone_defaults())
        
local nodes = {
	["desert_cobble_compressed"] = {
		description = S("Compressed Desert Cobblestone"),
		groups = {cracky = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:desert_cobble_compressed",
	recipe = {
		{"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"},
		{"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"},
		{"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"},
	}
})
minetest.register_craft({
	output = "default:desert_cobble 9",
	recipe = {
		{"moreblocks:desert_cobble_compressed"},
	}
})
]]--
