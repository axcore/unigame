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
minetest.register_craftitem("bbq:pepper_steak_raw", {
	description = ("Pepper Steak Raw"),
	inventory_image = "bbq_pepper_steak_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:pepper_steak_raw",
	type = "shapeless",
	recipe = {"group:food_pepper_ground", "bbq:beef_raw", "group:food_pepper_ground"}
})

minetest.register_craftitem("bbq:pepper_steak", {
	description = ("Pepper Steak"),
	inventory_image = "bbq_pepper_steak.png",
	on_use = minetest.item_eat(10),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:pepper_steak",
	recipe = "bbq:pepper_steak_raw",
	cooktime = 6,
})
]]--
