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
minetest.register_node("mapgen:savanna_stone", {
	description = "Savannah Stone",
	tiles = {"mapgen_savannah_stone.png"},
	groups = {cracky = 3, stone=1},
	drop = 'mapgen:savanna_cobblestone_stone',
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("mapgen:savanna_cobblestone_stone", {
	description = "Savanna Cobblestone",
	tiles = {"mapgen_savanna_cobblestone_stone.png"},
	groups = {cracky = 3, stone = 1},
	sounds = default.node_sound_stone_defaults()
})
]]--
