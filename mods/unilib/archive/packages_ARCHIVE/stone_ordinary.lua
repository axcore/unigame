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
-- From:    technic/technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("default:stone", {
        description = S("Stone"),
        tiles = {"default_stone.png"},
        groups = {cracky = 3, stone = 1},
        drop = "default:cobble",
        legacy_mineral = true,
        sounds = default.node_sound_stone_defaults(),
})
my_register_stair_and_slab(
        "stone",
        "default:stone",
        {cracky = 3},
        {"default_stone.png"},
        "Stone Stair",
        "Stone Slab",
        default.node_sound_stone_defaults(),
        true
)
local nodes = {
	["trap_stone"] = {
		description = S("Trap Stone"),
		drawtype = "glasslike_framed",
		tiles = {"default_stone.png^moreblocks_trap_box.png"},
		walkable = false,
		groups = {cracky = 3},
		paramtype = "light",
		is_ground_content = false,
		sounds = sound_stone,
		no_stairs = true,
	},
}
minetest.register_craft({
	output = "moreblocks:trap_stone",
	type = "shapeless",
	recipe = {"default:mese_crystal_fragment", "default:stone"},
})

minetest.register_node("default:stone_block", {
        description = S("Stone Block"),
        tiles = {"default_stone_block.png"},
        is_ground_content = false,
        groups = {cracky = 2, stone = 1},
        sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
        output = "default:stone_block 9",
        recipe = {
                {"default:stone", "default:stone", "default:stone"},
                {"default:stone", "default:stone", "default:stone"},
                {"default:stone", "default:stone", "default:stone"},
        }
})
my_register_stair_and_slab(
        "stone_block",
        "default:stone_block",
        {cracky = 2},
        {"default_stone_block.png"},
        "Stone Block Stair",
        "Stone Block Slab",
        default.node_sound_stone_defaults(),
        true
)

minetest.register_node("default:stonebrick", {
        description = S("Stone Brick"),
        paramtype2 = "facedir",
        place_param2 = 0,
        tiles = {"default_stone_brick.png"},
        is_ground_content = false,
        groups = {cracky = 2, stone = 1},
        sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
        output = "default:stonebrick 4",
        recipe = {
                {"default:stone", "default:stone"},
                {"default:stone", "default:stone"},
        }
})
my_register_stair_and_slab(
        "stonebrick",
        "default:stonebrick",
        {cracky = 2},
        {"default_stone_brick.png"},
        "Stone Brick Stair",
        "Stone Brick Slab",
        default.node_sound_stone_defaults(),
        false
)

minetest.register_node("default:cobble", {
        description = S("Cobblestone"),
        tiles = {"default_cobble.png"},
        is_ground_content = false,
        groups = {cracky = 3, stone = 2},
        sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
        type = "cooking",
        output = "default:stone",
        recipe = "default:cobble",
})
my_register_stair_and_slab(
        "cobble",
        "default:cobble",
        {cracky = 3},
        {"default_cobble.png"},
        "Cobblestone Stair",
        "Cobblestone Slab",
        default.node_sound_stone_defaults(),
        true
)
walls.register("walls:cobble", S("Cobblestone Wall"), {"default_cobble.png"},
                "default:cobble", default.node_sound_stone_defaults())
                
minetest.register_node("default:mossycobble", {
        description = S("Mossy Cobblestone"),
        tiles = {"default_mossycobble.png"},
        is_ground_content = false,
        groups = {cracky = 3, stone = 1},
        sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
        type = "cooking",
        output = "default:stone",
        recipe = "default:mossycobble",
})
minetest.register_craft({
	output = "default:mossycobble",
	type = "shapeless",
	recipe = {"default:junglegrass", "default:cobble"},
})
my_register_stair_and_slab(
        "mossycobble",
        "default:mossycobble",
        {cracky = 3},
        {"default_mossycobble.png"},
        "Mossy Cobblestone Stair",
        "Mossy Cobblestone Slab",
        default.node_sound_stone_defaults(),
        true
)
walls.register("walls:mossycobble", S("Mossy Cobblestone Wall"), {"default_mossycobble.png"},
                "default:mossycobble", default.node_sound_stone_defaults())

local nodes = {
	["cobble_compressed"] = {
		description = S("Compressed Cobblestone"),
		groups = {cracky = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
}
minetest.register_craft({
	output = "moreblocks:cobble_compressed",
	recipe = {
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"},
		{"default:cobble", "default:cobble", "default:cobble"},
	}
})
minetest.register_craft({
	output = "default:cobble 9",
	recipe = {
		{"moreblocks:cobble_compressed"},
	}
})

local recipes = {
	{"default:stone",              "technic:stone_dust"},
	{"default:cobble",           "default:gravel"},
}
for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end
register_dust("Stone",           "default:stone")
]]--
