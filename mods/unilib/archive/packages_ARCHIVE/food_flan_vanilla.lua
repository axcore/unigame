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
minetest.register_craftitem("farming:flan", {
	description = S("Vanilla Flan"),
	inventory_image = "farming_vanilla_flan.png",
	on_use = minetest.item_eat(6)
})
minetest.register_craft({
	output = "farming:flan",
	recipe = {
		{"group:food_sugar", "group:food_milk", "farming:caramel"},
		{"group:food_egg", "group:food_egg", "farming:vanilla_extract"}
	},
	replacements = {
		{"cucina_vegana:soy_milk", "vessels:drinking_glass"},
		{"group:food_milk", "bucket:bucket_empty"},
		{"farming:vanilla_extract", "vessels:glass_bottle"}
	}
})
]]--
