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
if minetest.get_modpath("animalia") then

minetest.register_craftitem("better_farming:strawberry_cake", {
	description = minetest.colorize("Yellow","Strawberry Cake"),
	on_use = minetest.item_eat(5),
	inventory_image = "better_farming_strawberry_cake.png",
})
end
minetest.register_craft({
	output = "better_farming:strawberry_cake",
	recipe = {
		{"better_farming:strawberry", "better_farming:strawberry", "better_farming:strawberry" },
		{"animalia:chicken_egg_fried", "farming:flour", "animalia:chicken_egg_fried" },
		{"farming:flour", "farming:flour", "farming:flour" }
	}
})
]]--
