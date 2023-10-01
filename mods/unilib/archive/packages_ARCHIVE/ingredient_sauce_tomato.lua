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
minetest.register_craftitem("bbq:tomato_sauce", {
	description = ("Tomato Sauce"),
	inventory_image = "bbq_tomato_sauce.png",
	groups = { food_tomato_sauce=1, vessel=1 },
	on_use = minetest.item_eat(2)
})
minetest.register_craft({
	type = "shapeless",
	output = "bbq:tomato_sauce",
	recipe = { "group:food_tomato" },
})
]]--
