---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pizza
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("pizza:uncooked_margherita", {
	description = "Uncooked pizza margherita",
	inventory_image = "pizza_margherita.png",
	stack_max = 1,
})
minetest.register_craft({
	output = "pizza:uncooked_margherita",
	recipe = {
		{"pizza:cactus_cheese"},
		{"pizza:tomato_sauce"},
		{"pizza:dought"}
	},
	replacements = {
		{"pizza:tomato_sauce", "vessels:glass_bottle"},
	}
})

minetest.register_craftitem("pizza:margherita", {
	description = "Pizza margherita slice",
	inventory_image = "pizza_margherita_slice.png",
	stack_max = 8,
	on_use = minetest.item_eat(10),
})
minetest.register_craft({
	type = "cooking",
	cooktime = 30,
	output = "pizza:margherita 8",
	recipe = "pizza:uncooked_margherita",
})
]]--
