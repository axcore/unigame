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
minetest.register_node("darkage:slate", {
	description = "Slate",
	tiles = {"darkage_slate.png","darkage_slate.png","darkage_slate_side.png"},
	is_ground_content = true,
	drop = 'darkage:slate_rubble',
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:slate_rubble",
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:slate",
	recipe = "darkage:shale",
})

minetest.register_node("darkage:slate_block", {
	description = "Slate Block",
	tiles = {"darkage_slate_block.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:slate_block 9",
	recipe = {
		{"darkage:slate", "darkage:slate", "darkage:slate"},
		{"darkage:slate", "darkage:slate", "darkage:slate"},
		{"darkage:slate", "darkage:slate", "darkage:slate"},
	}
})

minetest.register_node("darkage:slate_brick", {
	description = "Slate Brick",
	tiles = {"darkage_slate_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:slate_brick 4",
	recipe = {
		{"darkage:slate", "darkage:slate"},
		{"darkage:slate", "darkage:slate"},
	}
})

minetest.register_node("darkage:slate_rubble", {
	description = "Slate Rubble",
	tiles = {"darkage_slate_rubble.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:slate_tile", {
	description = "Slate Tile",
	tiles = {"darkage_slate_tile.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:slate_tile 2",
	recipe = {
		{"darkage:slate_brick", "darkage:slate_brick"},
		{"darkage:slate_brick", "darkage:slate_brick"},
	}
})
]]--
