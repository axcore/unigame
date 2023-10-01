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
minetest.register_craftitem("bbq:grilled_tomato", {
	description = ("Grilled Tomato"),
	inventory_image = "bbq_grilled_tomato.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:grilled_tomato",
	recipe = "group:food_tomato",
	cooktime = 4,
})
]]--
