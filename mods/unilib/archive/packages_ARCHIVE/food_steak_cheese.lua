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
minetest.register_craftitem("bbq:cheese_steak", {
	description = ("Cheese Steak"),
	inventory_image = "bbq_cheese_steak.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	output = "bbq:cheese_steak 2",
	type = "shapeless",
	recipe = {"farming:bread", "group:food_pepper", "bbq:beef", "group:food_cheese", "group:food_onion"}
})
]]--
