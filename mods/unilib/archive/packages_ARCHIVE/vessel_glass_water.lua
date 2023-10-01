---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:glass_water", {
	description = S("Glass of Water"),
	inventory_image = "farming_water_glass.png",
	groups = {food_water_glass = 1, flammable = 3, vessel = 1}
})
minetest.register_craft({
	output = "farming:glass_water 4",
	recipe = {
		{"vessels:drinking_glass", "vessels:drinking_glass"},
		{"vessels:drinking_glass", "vessels:drinking_glass"},
		{"bucket:bucket_river_water", ""}
	},
	replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}}
})
minetest.register_craft({
	output = "farming:glass_water 4",
	recipe = {
		{"vessels:drinking_glass", "vessels:drinking_glass"},
		{"vessels:drinking_glass", "vessels:drinking_glass"},
		{"bucket:bucket_water", "farming:hemp_fibre"}
	},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})
]]--
