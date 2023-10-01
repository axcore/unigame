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
minetest.register_craftitem("better_farming:marshmallow", {
	description = minetest.colorize("Pink","Marshmallow"),
	inventory_image = "marshmallow.png",
	on_use = minetest.item_eat(2),
	groups = {food_marshmallow = 1, flammable = 2},
})
minetest.register_craft({
	output = "better_farming:marshmallow",
	recipe = {
		{"better_farming:sugar", "better_farming:glass_bottle_with_water"},
		{"better_farming:sugar", "better_farming:sugar"},
		{"better_farming:sugar", "better_farming:strawberry"},
	}
})
]]--
