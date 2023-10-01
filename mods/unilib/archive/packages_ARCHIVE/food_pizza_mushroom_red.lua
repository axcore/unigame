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
minetest.register_craftitem("pizza:uncooked_rmush", {
	description = "Uncooked pizza with red mushrooms",
	inventory_image = "pizza_rmush.png",
	stack_max = 1,
})
minetest.register_craft({
	output = "pizza:uncooked_rmush",
	recipe = {
		{"flowers:mushroom_red","pizza:cactus_cheese","flowers:mushroom_red"},
		{"flowers:mushroom_red","pizza:tomato_sauce","flowers:mushroom_red"},
		{"flowers:mushroom_red","pizza:dought","flowers:mushroom_red"}
	},
	replacements = {
		{"pizza:tomato_sauce", "vessels:glass_bottle"},
	}
})

minetest.register_craftitem("pizza:rmush", {
	description = "Pizza r-mush slice",
	inventory_image = "pizza_rmush_slice.png",
	stack_max = 8,
	on_use = function(itemstack, user, pointed_thing)
		playereffects.apply_effect_type("highjump", 30, user)
		itemstack:take_item()
		return itemstack
	end
})
minetest.register_craft({
	type = "cooking",
	cooktime = 30,
	output = "pizza:rmush 8",
	recipe = "pizza:uncooked_rmush",
})
]]--
