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
minetest.register_node("darkage:ors", {
	description = "Old Red Sandstone",
	tiles = {"darkage_ors.png"},
	is_ground_content = true,
	drop = "darkage:ors_rubble",
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:ors",
	recipe = "darkage:ors_rubble",
})
minetest.register_craft({
	output = "darkage:ors 4",
	recipe = {
		{"default:sandstone", "default:sandstone"},
		{"default:iron_lump", "default:sandstone"},
	}
})

minetest.register_node("darkage:ors_block", {
	description = "Old Red Sandstone Block",
	tiles = {"darkage_ors_block.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:ors_block 9",
	recipe = {
		{"darkage:ors", "darkage:ors", "darkage:ors"},
		{"darkage:ors", "darkage:ors", "darkage:ors"},
		{"darkage:ors", "darkage:ors", "darkage:ors"},
	}
})

minetest.register_node("darkage:ors_brick", {
	description = "Old Red Sandstone Brick",
	tiles = {"darkage_ors_brick.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:ors_brick 4",
	recipe = {
		{"darkage:ors", "darkage:ors"},
		{"darkage:ors", "darkage:ors"},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:ors_brick",
	recipe = "default:desert_stone",
})

minetest.register_node("darkage:ors_rubble", {
	description = "Old Red Sandstone Rubble",
	tiles = {"darkage_ors_rubble.png"},
	is_ground_content = true,
	groups = {cracky = 3, crumbly=2, stone = 2},
	sounds = default.node_sound_stone_defaults()
})
]]--
