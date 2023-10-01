---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
local nodes = {
	["wood_tile"] = {
		description = S("Wooden Tile"),
		groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		is_ground_content = false,
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = {"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90"},
		sounds = sound_wood,
	},
	["wood_tile_flipped"] = {
		description = S("Wooden Tile") .. deprecated,
		tiles = {"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR180",
		"default_wood.png^moreblocks_wood_tile.png^[transformR180"},
		no_stairs = true,
		on_place = wood_tile_replace
	},
	["wood_tile_center"] = {
		description = S("Centered Wooden Tile"),
		groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		is_ground_content = false,
		tiles = {"default_wood.png^moreblocks_wood_tile_center.png"},
		sounds = sound_wood,
	},
	["wood_tile_full"] = {
		description = S("Full Wooden Tile"),
		groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		is_ground_content = false,
		tiles = tile_tiles("wood_tile_full"),
		sounds = sound_wood,
	},
	["wood_tile_offset"] = {
		description = S("Offset Wooden Tile"),
		paramtype2 = "facedir",
		place_param2 = 0,
		groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		is_ground_content = false,
		tiles = {"default_wood.png^moreblocks_wood_tile_offset.png"},
		sounds = sound_wood,
		no_stairs = true,
	},
	["wood_tile_down"] = {
		description = S("Downwards Wooden Tile") .. deprecated,
		tiles = {"default_wood.png^[transformR180^moreblocks_wood_tile_offset.png^[transformR180"},
		no_stairs = true,
		on_place = wood_tile_replace
	},
	["wood_tile_left"] = {
		description = S("Leftwards Wooden Tile") .. deprecated,
		tiles = {"default_wood.png^[transformR270^moreblocks_wood_tile_offset.png^[transformR270"},
		no_stairs = true,
		on_place = wood_tile_replace
	},
	["wood_tile_right"] = {
		description = S("Rightwards Wooden Tile") .. deprecated,
		tiles = {"default_wood.png^[transformR90^moreblocks_wood_tile_offset.png^[transformR90"},
		no_stairs = true,
		on_place = wood_tile_replace
	},
}

minetest.register_craft({
	output = "moreblocks:wood_tile 9",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})
-- This must be registered after `moreblocks:wood_tile` to avoid recipe conflicts,
-- since `moreblocks:wood_tile` is part of `group:wood`
minetest.register_craft({
	output = "moreblocks:wood_tile_center 9",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "moreblocks:wood_tile", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	}
})
minetest.register_craft({
	output = "moreblocks:wood_tile_full 4",
	recipe = {
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
		{"moreblocks:wood_tile", "moreblocks:wood_tile"},
	}
})
minetest.register_craft({
	output = "moreblocks:wood_tile_offset",
	recipe = {
		{"default:stick"},
		{"moreblocks:wood_tile_center"},
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_down"}
})
test.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_left"}
})
minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:wood_tile_offset",
	recipe = {"moreblocks:wood_tile_right"}
})
]]--
