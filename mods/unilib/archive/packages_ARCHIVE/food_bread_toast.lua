---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("farming:toast", {
	description = S("Toast"),
	inventory_image = "farming_toast.png",
	on_use = minetest.item_eat(1),
	groups = {food_toast = 1, flammable = 2}
})
minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "farming:toast",
	recipe = "farming:bread_slice"
})

minetest.register_craftitem("farming:toast_sandwich", {
	description = S("Toast Sandwich"),
	inventory_image = "farming_toast_sandwich.png",
	on_use = minetest.item_eat(4),
	groups = {flammable = 2}
})
minetest.register_craft({
	output = "farming:toast_sandwich",
	recipe = {
		{"farming:bread_slice"},
		{"farming:toast"},
		{"farming:bread_slice"}
	}
})
]]--
