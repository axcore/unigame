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
minetest.register_craftitem("farming:sunflower_bread", {
	description = S("Sunflower Seed Bread"),
	inventory_image = "farming_sunflower_bread.png",
	on_use = minetest.item_eat(8),
	groups = {food_bread = 1, flammable = 2}
})
minetest.register_craft({
	output = "farming:sunflower_bread",
	recipe = {{"group:food_sunflower_seeds_toasted", "group:food_bread", "group:food_sunflower_seeds_toasted"}}
})
]]--
