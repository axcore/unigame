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
minetest.register_craftitem("farming:sunflower_seeds_toasted", {
	description = S("Toasted Sunflower Seeds"),
	inventory_image = "farming_sunflower_seeds_toasted.png",
	groups = {food_sunflower_seeds_toasted = 1, flammable = 2},
	on_use = minetest.item_eat(1)
})
minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:sunflower_seeds_toasted",
	recipe = "farming:seed_sunflower"
})
]]--
