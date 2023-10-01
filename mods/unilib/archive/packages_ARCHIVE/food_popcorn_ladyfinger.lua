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
minetest.register_craftitem("better_farming:pop_corn", {
	description = minetest.colorize("Yellow","Pop Corn"),
	on_use = minetest.item_eat(1),
	inventory_image = "better_farming_pop_corn.png",
})
minetest.register_craft({
	type = "cooking",
	output = "better_farming:pop_corn 2",
	recipe = "better_farming:corn",
})
]]--
