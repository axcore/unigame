---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farlands
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("decoblocks:old_stone_tiles", {
	description = "Old Stone Tiles",
	tiles = {"decoblocks_old_stone_tiles.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'decoblocks:old_stone_tiles 4',
	recipe = {
		{'default:stone_block', 'default:stone_block'},
		{'default:stone_block', 'default:stone_block'},
	}
})

minetest.register_node("decoblocks:old_stone_tiles_with_dirt", {
	description = "Old Stone Tiles With Dirt",
	tiles = {"decoblocks_old_stone_tiles_with_dirt.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = 'decoblocks:old_stone_tiles_with_dirt 2',
	recipe = {
		'decoblocks:old_stone_tiles',
		"default:dirt",
		'decoblocks:old_stone_tiles',
	}
})

minetest.register_node("decoblocks:moss_old_stone_tiles", {
	description = "Mossy Old Stone Tiles",
	tiles = {"decoblocks_mossy_old_stone_tiles.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
]]--
