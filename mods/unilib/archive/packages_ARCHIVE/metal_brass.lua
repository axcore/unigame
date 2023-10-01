---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    basic_materials
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
--
-- From:    technic
-- Code:    LGPL 2.0
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
register_dust("Brass",           "basic_materials:brass_ingot")

minetest.register_craftitem("basic_materials:brass_ingot", {
	description = S("Brass Ingot"),
	inventory_image = "basic_materials_brass_ingot.png",
})
minetest.register_craft( {
	type = "shapeless",
	output = "basic_materials:brass_ingot 3",
	recipe = {
		"default:copper_ingot",
		"default:copper_ingot",
		"moreores:silver_ingot",
	},
})
if not minetest.get_modpath("moreores") then
    -- Without moreores, there still should be a way to create brass.
    minetest.register_craft( {
        output = "basic_materials:brass_ingot 9",
        recipe = {
	    {"default:copper_ingot", "default:tin_ingot", "default:copper_ingot"},
	    {"default:gold_ingot", "default:copper_ingot", "default:gold_ingot"},
	    {"default:copper_ingot", "default:tin_ingot", "default:copper_ingot"},
        },
    })
end

minetest.register_node("basic_materials:brass_block", {
	description = S("Brass Block"),
	tiles = { "basic_materials_brass_block.png" },
	is_ground_content = false,
	groups = {cracky=1, level=2},
	sounds = default.node_sound_metal_defaults()
})
minetest.register_craft( {
	output = "basic_materials:brass_block",
	recipe = {
		{ "basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot" },
		{ "basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot" },
		{ "basic_materials:brass_ingot", "basic_materials:brass_ingot", "basic_materials:brass_ingot" },
	},
})
minetest.register_craft( {
	type = "shapeless",
	output = "basic_materials:brass_ingot 9",
	recipe = { "basic_materials:brass_block" },
})
]]--
