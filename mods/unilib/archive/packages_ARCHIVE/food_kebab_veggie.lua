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
minetest.register_craftitem("bbq:veggie_kebab_raw", {
	description = ("Veggie Kebab Raw"),
	inventory_image = "bbq_veggie_kebab_raw.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "bbq:veggie_kebab_raw 2",
	type = "shapeless",
	recipe = {"group:food_pepper", "group:food_potato", "group:food_tomato", "flowers:mushroom_brown", "default:stick"}
})

minetest.register_craftitem("bbq:veggie_kebab", {
	description = ("Veggie Kebab"),
	inventory_image = "bbq_veggie_kebab.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:veggie_kebab",
	recipe = "bbq:veggie_kebab_raw",
	cooktime = 8,
})
]]--
