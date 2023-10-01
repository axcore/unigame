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
minetest.register_node("decoblocks:rusty_steel_plating", {
	description = "Rusty Plating",
	tiles = {"decoblocks_rusty_steel_plating.png"},
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = 'decoblocks:rusty_steel_plating 4',
	recipe = {
		'default:steelblock',
		"group:water_bucket",
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"},
		{"bucket:bucket_river_water", "bucket:bucket_empty"},
		{"bucket:bucket_dirty_water", "bucket:bucket_empty"},
	},
})
]]--
