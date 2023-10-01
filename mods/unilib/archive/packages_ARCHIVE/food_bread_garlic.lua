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
minetest.register_craftitem("farming:garlic_bread", {
	description = S("Garlic Bread"),
	inventory_image = "farming_garlic_bread.png",
	groups = {flammable = 3},
	on_use = minetest.item_eat(2)
})
minetest.register_craft({
--	type = "shapeless",
	output = "farming:garlic_bread",
	recipe = {
		{"group:food_toast", "group:food_garlic_clove", "group:food_garlic_clove"}
	}
})
]]--
