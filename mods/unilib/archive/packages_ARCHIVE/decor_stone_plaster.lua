---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    darkage
-- Code:    WTFPL
-- Media:   WTFPL
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("darkage:chalked_bricks_with_plaster", {
	description = "Chalked Bricks with Plaster",
	tiles = {"darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_D.png)", "darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_B.png)", 
		"darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_C.png)", "darkage_chalk.png^(darkage_chalked_bricks.png^[mask:darkage_plaster_mask_A.png)", 
		"darkage_chalked_bricks.png", "darkage_chalk.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	drop = 'default:cobble',
	groups = {cracky=3, not_cuttable=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "darkage:chalked_bricks_with_plaster 2",
	recipe = {
		{"darkage:chalked_bricks", "darkage:chalk_powder"},
		{"darkage:chalked_bricks", "darkage:chalk_powder"},
	}
})
minetest.register_craft({
	output = "darkage:chalked_bricks_with_plaster 2",
	recipe = {
		{"darkage:chalk_powder", "darkage:chalked_bricks"},
		{"darkage:chalk_powder", "darkage:chalked_bricks"},
	}
})

minetest.register_node("darkage:cobble_with_plaster", {
	description = "Cobblestone with Plaster",
	tiles = {"darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_D.png)", "darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_B.png)", 
		"darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_C.png)", "darkage_chalk.png^(default_cobble.png^[mask:darkage_plaster_mask_A.png)", 
		"default_cobble.png", "darkage_chalk.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	drop = 'default:cobble',
	groups = {cracky=3, not_cuttable=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "darkage:cobble_with_plaster 2",
	recipe = {
		{"default:cobble", "darkage:chalk_powder"},
		{"default:cobble", "darkage:chalk_powder"},
	}
})
minetest.register_craft({
	output = "darkage:cobble_with_plaster 2",
	recipe = {
		{"darkage:chalk_powder", "default:cobble"},
		{"darkage:chalk_powder", "default:cobble"},
	}
})
]]--
