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
minetest.register_craftitem("ethereal:agar_powder", {
	description = S("Agar Powder"),
	inventory_image = "ethereal_agar_powder.png",
	groups = {food_gelatin = 1, flammable = 2}
})
minetest.register_craft({
	output = "ethereal:agar_powder 3",
	recipe = {
		{"group:food_seaweed", "group:food_seaweed", "group:food_seaweed"},
		{"bucket:bucket_water", "bucket:bucket_water", "default:torch"},
		{"bucket:bucket_water", "bucket:bucket_water", "default:torch"}
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty 4"}
	}
})
]]--
