---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    GLEMr6
-- Code:    LGPL 2.1
-- Media:   unknown
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
	minetest.register_node("lib_materials:stone_castle_slate", {
		description = S("Stone - Castle Slate"),
		tiles = {"castle_slate.png"},
		is_ground_content = true,
		groups = {cracky = 3, stone = 1},
		drop = 'lib_materials:stone_castle_slate',
		legacy_mineral = true,
		sounds = default.node_sound_stone_defaults(),
	})
]]--
