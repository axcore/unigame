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
minetest.register_craftitem("better_farming:gingerbread", {
	description = minetest.colorize("Brown","GingerBread"),
	inventory_image = "gingerbread.png",
	on_use = minetest.item_eat(2),
	groups = {food_cotton_candy = 1, flammable = 2},
})
minetest.register_craft({
	type = "cooking",
	output = "better_farming:gingerbread",
	recipe = "better_farming:gingerdough",
})

minetest.register_craftitem("better_farming:gingerbread_man", {
	description = minetest.colorize("Brown","Girgerbread Man"),
	inventory_image = "gingerbread_man_1.png",
	on_use = minetest.item_eat(1),
	groups = {food_cotton_candy = 1, flammable = 2},
})
minetest.register_craft({
	output = "better_farming:gingerbread_man",
	recipe = {
		{"", "better_farming:gingerdough", ""},
		{"better_farming:gingerdough", "better_farming:gingerdough", "better_farming:gingerdough"},
		{"better_farming:gingerdough", "", "better_farming:gingerdough"},
	}
})
]]--
