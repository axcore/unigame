---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    columnia
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
--
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_materials:rusty", {
	description = "Rusty",
	tiles = {"columnia_rusty.png"},
	is_ground_content = false,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
		output = 'lib_materials:rusty 8',
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:water_source", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		},
})

minetest.register_node("columnia:rusty_block", {
	description = "Rusty Block",
	tiles = {"columnia_rusty_block.png"},
	is_ground_content = true,
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
		output = 'columnia:rusty_block 8',
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "columnia:blueprint", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		},
		replacements = {{"columnia:blueprint", "columnia:blueprint"}},
})
]]--
