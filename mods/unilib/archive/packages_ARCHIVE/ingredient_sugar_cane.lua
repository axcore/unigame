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
minetest.register_craftitem("better_farming:sugar", {
	description = minetest.colorize("Pink","Sugar"),
	inventory_image = "sugar.png",
	on_use = minetest.item_eat(1),
	groups = {food_sugar = 1, flammable = 2},
})
minetest.register_craft({
	output = "better_farming:sugar 3",
	recipe = {
		{"default:papyrus", "default:papyrus", "default:papyrus"},
		{"default:papyrus", "farming:flour", "default:papyrus"},
		{"default:papyrus", "default:papyrus", "default:papyrus"},
	}
})
minetest.register_craft({
	output = "better_farming:sugar",
	recipe = {
		{"better_farming:jute"},
	}
})
]]--
