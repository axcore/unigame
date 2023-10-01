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
minetest.register_node("darkage:gneiss", {
	description = "Gneiss",
	tiles = {"darkage_gneiss.png"},
	is_ground_content = true,
	groups = {cracky = 3, stone = 1},
	drop = get_node_drops("darkage:gneiss", "darkage:gneiss_rubble"),
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:gneiss_rubble",
})
minetest.register_craft({
	type = "cooking",
	output = "darkage:gneiss",
	recipe = "darkage:schist",
})

minetest.register_node("darkage:gneiss_block", {
	description = "Gneiss Block",
	tiles = {"darkage_gneiss_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:gneiss_block 9",
	recipe = {
		{"darkage:gneiss", "darkage:gneiss", "darkage:gneiss"},
		{"darkage:gneiss", "darkage:gneiss", "darkage:gneiss"},
		{"darkage:gneiss", "darkage:gneiss", "darkage:gneiss"},
	}
})

minetest.register_node("darkage:gneiss_brick", {
	description = "Gneiss Brick",
	tiles = {"darkage_gneiss_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:gneiss_brick 4",
	recipe = {
		{"darkage:gneiss", "darkage:gneiss"},
		{"darkage:gneiss", "darkage:gneiss"},
	}
})

minetest.register_node("darkage:gneiss_rubble", {
	description = "Gneiss Rubble",
	tiles = {"darkage_gneiss_rubble.png"},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults()
})
]]--
