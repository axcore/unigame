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
minetest.register_craftitem("better_farming:chips", {
	description = minetest.colorize("Yellow","Chips"),
	on_use = minetest.item_eat(1),
	inventory_image = "chips.png",
})
minetest.register_craft({
	type = "cooking",
	output = "better_farming:chips 3",
	recipe = "better_farming:potatoes",
})
]]--
