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
minetest.register_craftitem("bbq:smoked_pepper", {
	description = ("Smoked Pepper"),
	inventory_image = "bbq_smoked_pepper.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:smoked_pepper",
	recipe = "group:food_pepper",
	cooktime = 9,
})
]]--
