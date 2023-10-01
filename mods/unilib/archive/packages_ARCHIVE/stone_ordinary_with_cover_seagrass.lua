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
minetest.register_node("mapgen:stone_with_sea_grass", {
	description = "Stone With Sea Grass",
	tiles = {"mapgen_sea_grass.png", "default_stone.png",
	{name = "default_stone.png^mapgen_sea_grass_side.png",
	tileable_vertical = false}},
	groups = {crumbly = 3,},
	drop = 'mapgen:seagrass_1',
	sounds = default.node_sound_stone_defaults()
})
]]--
