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
minetest.register_craftitem("bbq:lamb_kebab_raw", {
	description = ("Lamb Kebab Raw"),
	inventory_image = "bbq_lamb_kebab_raw.png",
	on_use = minetest.item_eat(2),
})
minetest.register_craft({
	output = "bbq:lamb_kebab_raw 4",
	type = "shapeless",
	recipe = {"group:food_pepper", "mobs:mutton_raw", "default:stick", "flowers:mushroom_brown", "group:food_onion"}
})

minetest.register_craftitem("bbq:lamb_kebab", {
	description = ("Lamb Kebab"),
	inventory_image = "bbq_lamb_kebab.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:lamb_kebab",
	recipe = "bbq:lamb_kebab_raw",
	cooktime = 10,
})
]]--
