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
minetest.register_node("darkage:basalt", {
	description = "Basalt",
	tiles = {"darkage_basalt.png"},
	is_ground_content = true,
	drop = get_node_drops("darkage:basalt","darkage:basalt_rubble"),
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:basalt",
	recipe = "darkage:basalt_rubble",
})

minetest.register_node("darkage:basalt_block", {
	description = "Basalt Block",
	tiles = {"darkage_basalt_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:basalt_block 9",
	recipe = {
		{"darkage:basalt", "darkage:basalt", "darkage:basalt"},
		{"darkage:basalt", "darkage:basalt", "darkage:basalt"},
		{"darkage:basalt", "darkage:basalt", "darkage:basalt"},
	}
})

minetest.register_node("darkage:basalt_brick", {
	description = "Basalt Brick",
	tiles = {"darkage_basalt_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:basalt_brick 4",
	recipe = {
		{"darkage:basalt", "darkage:basalt"},
		{"darkage:basalt", "darkage:basalt"},
	}
})

minetest.register_node("darkage:basalt_rubble", {
	description = "Basalt Rubble",
	tiles = {"darkage_basalt_rubble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:basalt_rubble 4",
	recipe = {
		{"default:cobble",		"default:cobble"},
		{"default:coal_lump",	"default:coal_lump"},
	}
})
]]--
