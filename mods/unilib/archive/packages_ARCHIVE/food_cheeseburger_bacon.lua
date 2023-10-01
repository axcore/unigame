---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bbq:bacon_cheeseburger", {
	description = ("Bacon Cheeseburger"),
	inventory_image = "bbq_bacon_cheeseburger.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	output = "bbq:bacon_cheeseburger 3",
	type = "shapeless",
	recipe = {"farming:bread", "bbq:bacon", "bbq:hamburger_patty", "group:food_cheese"}
})
]]--
