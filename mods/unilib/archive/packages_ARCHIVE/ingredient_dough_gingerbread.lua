---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("better_farming:gingerdough", {
	description = minetest.colorize("Brown","GingerDough"),
	inventory_image = "gingerdough.png",
	on_use = minetest.item_eat(1),
	groups = {food_cotton_candy = 1, flammable = 2},
})
minetest.register_craft({
	output = "better_farming:gingerdough 3",
	recipe = {
		{"better_farming:glass_bottle_with_water", "farming:flour", "better_farming:ginger"},
		{"better_farming:sugar", "better_farming:sugar", ""},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "better_farming:gingerdough",
	recipe = "better_farming:ginger",
})
]]--
