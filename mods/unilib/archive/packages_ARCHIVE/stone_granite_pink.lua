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
minetest.register_node("mapgen:granite_brown", {
	description = "Brown Granite",
	tiles = {"mapgen_granite_brown.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("decoblocks:refined_granite_brown", {
	description = "Refined Brown Granite",
	tiles = {"decoblocks_refined_granite_brown.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "decoblocks:refined_granite_brown",
	recipe = "mapgen:granite_brown",
	cooktime = 5,
})
]]--
