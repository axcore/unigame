---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bonemeal
-- Code:    MIT
-- Media:   CC0-1.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bonemeal:gelatin_powder", {
	description = S("Gelatin Powder"),
	inventory_image = "bonemeal_gelatin_powder.png",
	groups = {food_gelatin = 1, flammable = 2}
})
minetest.register_craft({
	output = "bonemeal:gelatin_powder 4",
	recipe = {
		{"group:bone", "group:bone", "group:bone"},
		{"bucket:bucket_water", "bucket:bucket_water", "bucket:bucket_water"},
		{"bucket:bucket_water", "default:torch", "bucket:bucket_water"},
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty 5"},
	}
})
]]--
