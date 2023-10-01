---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_node("ethereal:blue_marble", {
	description = S("Blue Marble"),
	tiles = {"ethereal_blue_marble.png"},
	groups = {cracky = 1, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
do_stair(
	"Blue Marble",
	"blue_marble",
	"ethereal:blue_marble",
	{cracky = 1},
	{"ethereal_blue_marble.png"},
	default.node_sound_stone_defaults())
    
minetest.register_node("ethereal:blue_marble_tile", {
	description = S("Blue Marble Tile"),
	tiles = {"ethereal_blue_marble_tile.png"},
	groups = {cracky = 1, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "ethereal:blue_marble_tile 9",
	recipe = {
		{"ethereal:blue_marble", "ethereal:blue_marble", "ethereal:blue_marble"},
		{"ethereal:blue_marble", "ethereal:blue_marble", "ethereal:blue_marble"},
		{"ethereal:blue_marble", "ethereal:blue_marble", "ethereal:blue_marble"}
	}
})
do_stair(
	"Blue Marble Tile",
	"blue_marble_tile",
	"ethereal:blue_marble_tile",
	{cracky = 1},
	{"ethereal_blue_marble_tile.png"},
	default.node_sound_stone_defaults())
]]--
