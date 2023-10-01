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
	minetest.register_node("lib_materials:rockwall_stone", {
		description = S("Rockwall - Stone"),
		tiles = {"lib_materials_rockwall_stone.png"},
		is_ground_content = true,
		groups = {cracky = 3, stone = 1, level = 2},
		drop = 'lib_materials:stone_brown',
		legacy_mineral = true,
		sounds = default.node_sound_stone_defaults(),
	})
]]--
