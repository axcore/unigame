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
minetest.register_node("decoblocks:stucco", {
	description = "Stucco",
	tiles = {"decoblocks_stucco.png"},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = 'decoblocks:stucco 8',
	recipe = {
		'mapgen:limestone',
		'mapgen:limestone',
		'mapgen:limestone',
		'mapgen:limestone',
		"group:water_bucket",
		'group:sand',
		'group:sand',
		'group:sand',
		'group:sand',
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"},
		{"bucket:bucket_river_water", "bucket:bucket_empty"},
		{"bucket:bucket_dirty_water", "bucket:bucket_empty"},
	},
})
]]--
