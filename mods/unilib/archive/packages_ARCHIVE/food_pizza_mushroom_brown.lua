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
minetest.register_craftitem("pizza:uncooked_bmush", {
	description = "Uncooked pizza with brown mushrooms",
	inventory_image = "pizza_bmush.png",
	stack_max = 1,
})
minetest.register_craft({
	output = "pizza:uncooked_bmush",
	recipe = {
		{"flowers:mushroom_brown","pizza:cactus_cheese","flowers:mushroom_brown"},
		{"flowers:mushroom_brown","pizza:tomato_sauce","flowers:mushroom_brown"},
		{"flowers:mushroom_brown","pizza:dought","flowers:mushroom_brown"}
	},
	replacements = {
		{"pizza:tomato_sauce", "vessels:glass_bottle"},
	}
})

minetest.register_craftitem("pizza:bmush", {
	description = "Pizza b-mush slice",
	inventory_image = "pizza_bmush_slice.png",
	stack_max = 8,
	on_use = function(itemstack, user, pointed_thing)
		playereffects.apply_effect_type("high_speed", 30, user)
		itemstack:take_item()
		return itemstack
	end
})
minetest.register_craft({
	type = "cooking",
	cooktime = 30,
	output = "pizza:bmush 8",
	recipe = "pizza:uncooked_bmush",
})
]]--
