---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    default
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("default:tin_lump", {
	description = S("Tin Lump"),
	inventory_image = "default_tin_lump.png"
})

local recipes = {
	{"default:tin_lump",           "technic:tin_dust 2"},
}
for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end
register_dust("Tin",             "default:tin_ingot")

minetest.register_craftitem("default:tin_ingot", {
	description = S("Tin Ingot"),
	inventory_image = "default_tin_ingot.png"
})
minetest.register_craft({
	type = "cooking",
	output = "default:tin_ingot",
	recipe = "default:tin_lump",
})
minetest.register_craft({
	output = "default:tin_ingot 9",
	recipe = {
		{"default:tinblock"},
	}
})

minetest.register_node("default:tinblock", {
	description = S("Tin Block"),
	tiles = {"default_tin_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.register_craft({
	output = "default:tinblock",
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
	}
})
my_register_stair_and_slab(
	"tinblock",
	"default:tinblock",
	{cracky = 1, level = 2},
	{"default_tin_block.png"},
	"Tin Block Stair",
	"Tin Block Slab",
	default.node_sound_metal_defaults(),
	true
)
]]--
