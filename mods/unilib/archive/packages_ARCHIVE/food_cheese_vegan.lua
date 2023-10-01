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
minetest.register_craftitem("farming:cheese_vegan", {
	description = S("Vegan Cheese"),
	inventory_image = "farming_cheese_vegan.png",
	on_use = minetest.item_eat(2),
	groups = {food_cheese = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:cheese_vegan",
	recipe = {
		{"farming:soy_milk", "farming:soy_milk", "farming:soy_milk"},
		{"group:food_salt", "group:food_peppercorn", "farming:bottle_ethanol"},
		{"group:food_gelatin", "group:food_pot", ""}
	},
	replacements = {
		{"farming:soy_milk", "vessels:drinking_glass 3"},
		{"farming:pot", "farming:pot"},
		{"farming:bottle_ethanol", "vessels:glass_bottle"}
	}
})
minetest.register_craft({
	output = "farming:cheese_vegan",
	recipe = {
		{"farming:soy_milk", "farming:soy_milk", "farming:soy_milk"},
		{"group:food_salt", "group:food_peppercorn", "group:food_lemon"},
		{"group:food_gelatin", "group:food_pot", ""}
	},
	replacements = {
		{"farming:soy_milk", "vessels:drinking_glass 3"},
		{"farming:pot", "farming:pot"}
	}
})
]]--
