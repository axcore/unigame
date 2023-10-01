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
minetest.register_craftitem("bbq:portebello_steak_raw", {
	description = ("Portebello Steak Raw"),
	inventory_image = "bbq_portebello_steak_raw.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = "bbq:portebello_steak_raw",
	type = "shapeless",
	recipe = {"group:food_pepper_ground", "bbq:steak_sauce", "flowers:mushroom_brown"}
})

minetest.register_craftitem("bbq:portebello_steak", {
	description = ("Portebello Steak"),
	inventory_image = "bbq_portebello_steak.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:portebello_steak",
	recipe = "bbq:portebello_steak_raw",
	cooktime = 6,
})
]]--
