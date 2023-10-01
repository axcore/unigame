---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    moreblocks
-- Code:    zlib
-- Media:   CC0 1.0 Universal
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("default:copper_lump", {
	description = S("Copper Lump"),
	inventory_image = "default_copper_lump.png"
})

local recipes = {
	{"default:copper_lump",        "technic:copper_dust 2"},
}
for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end
register_dust("Copper",          "default:copper_ingot")

minetest.register_craftitem("default:copper_ingot", {
	description = S("Copper Ingot"),
	inventory_image = "default_copper_ingot.png"
})
minetest.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "default:copper_lump",
})
minetest.register_craft({
	output = "default:copper_ingot 9",
	recipe = {
		{"default:copperblock"},
	}
})

minetest.register_node("default:copperblock", {
	description = S("Copper Block"),
	tiles = {"default_copper_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.register_craft({
	output = "default:copperblock",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	}
})
my_register_stair_and_slab(
	"copperblock",
	"default:copperblock",
	{cracky = 1, level = 2},
	{"default_copper_block.png"},
	"Copper Block Stair",
	"Copper Block Slab",
	default.node_sound_metal_defaults(),
	true
)

local nodes = {
	["copperpatina"] = {
		description = S("Copper Patina Block"),
		groups = {cracky = 1, level = 2},
		is_ground_content = false,
		sounds = sound_metal,
	},
}
minetest.register_craft({
	type = "shapeless",
	output = "moreblocks:copperpatina",
	recipe = {"group:water_bucket", "default:copperblock"},
	replacements = {
		{"group:water_bucket", "bucket:bucket_empty"}
	}
})
minetest.register_craft({
	output = "default:copper_ingot 9",
	recipe = {
		{"moreblocks:copperpatina"},
	}
})
]]--
