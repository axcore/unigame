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
minetest.register_craftitem("farming:tofu", {
	description = S("Tofu"),
	inventory_image = "farming_tofu.png",
	groups = {food_tofu = 1, food_meat_raw = 1, flammable = 2},
	on_use = minetest.item_eat(3)
})
minetest.register_craft({
	output = "farming:tofu",
	recipe = {
		{"farming:baking_tray", "group:food_soy", "group:food_soy"},
		{"group:food_soy", "group:food_soy", "group:food_soy"}
	},
	replacements = {{"farming:baking_tray", "farming:baking_tray"}}
})

minetest.register_craftitem("farming:tofu_cooked", {
	description = S("Cooked Tofu"),
	inventory_image = "farming_tofu_cooked.png",
	groups = {food_meat = 1, flammable = 2},
	on_use = minetest.item_eat(6)
})
minetest.register_craft({
	type = "cooking",
	output = "farming:tofu_cooked",
	recipe = "farming:tofu",
	cooktime = 5
})
]]--
