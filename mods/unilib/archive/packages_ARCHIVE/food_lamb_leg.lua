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
minetest.register_craftitem("bbq:leg_lamb_raw", {
	description = ("Leg of Lamb Raw"),
	inventory_image = "bbq_leg_lamb_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:leg_lamb_raw 2",
	type = "shapeless",
	recipe = {"group:food_garlic_clove", "mobs:mutton_raw", "mobs:mutton_raw"}
})

minetest.register_craftitem("bbq:leg_lamb", {
	description = ("Leg of Lamb"),
	inventory_image = "bbq_leg_lamb.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:leg_lamb",
	recipe = "bbq:leg_lamb_raw",
	cooktime = 10,
})
]]--
