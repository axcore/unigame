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
minetest.register_node("darkage:marble", {
	description = "Marble",
	tiles = {"darkage_marble.png"},
	is_ground_content = true,
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("darkage:marble_tile", {
	description = "Marble Tile",
	tiles = {"darkage_marble_tile.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "darkage:marble_tile 2",
	recipe = {
		{"darkage:marble", "darkage:marble"},
		{"darkage:marble", "darkage:marble"},
	}
})
]]--
