---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr4
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("lib_materials:stone_sandstone_white_gravel", {
	description = S("Stone -  - White Sandstone Gravel"),
	tiles = {"lib_materials_stone_sandstone_white_gravel.png"},
	is_ground_content = true,
	groups = {cracky = 3, stone = 1, level = 2},
	drop = 'lib_materials:stone_sandstone_white_gravel',
	legacy_mineral = true,
	sounds = default.node_sound_gravel_defaults(),
})
minetest.register_node("lib_materials:stone_sandstone_white_brick", {
	description = S("Stone -  - White Sandstone Brick"),
	tiles = {"lib_materials_stone_sandstone_white_brick.png"},
	is_ground_content = true,
	groups = {cracky = 3, stone = 1, level = 2},
	drop = 'lib_materials:stone_sandstone_white_brick',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
]]--
