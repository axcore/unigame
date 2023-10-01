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
minetest.register_craftitem("bbq:hamburger_patty_raw", {
	description = ("Hamburger Patty Raw"),
	inventory_image = "bbq_hamburger_patty_raw.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "bbq:hamburger_patty_raw",
	type = "shapeless",
	recipe = {"bbq:beef_raw"}
})

minetest.register_craftitem("bbq:hamburger_patty", {
	description = ("Hamburger Patty"),
	inventory_image = "bbq_hamburger_patty.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craft({
	type = "cooking",
	output = "bbq:hamburger_patty",
	recipe = "bbq:hamburger_patty_raw",
	cooktime = 5,
})

minetest.register_craftitem("bbq:hamburger", {
	description = ("Hamburger"),
	inventory_image = "bbq_hamburger.png",
	on_use = minetest.item_eat(9),
})
minetest.register_craft({
	output = "bbq:hamburger 2",
	type = "shapeless",
	recipe = {"farming:bread", "bbq:hamburger_patty"}
})
]]--
