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
minetest.register_craftitem("farming:beetroot_soup", {
	description = S("Beetroot Soup"),
	inventory_image = "farming_beetroot_soup.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(6, "farming:bowl")
})
minetest.register_craft({
	output = "farming:beetroot_soup",
	recipe = {
		{"group:food_beetroot", "group:food_beetroot", "group:food_beetroot"},
		{"group:food_beetroot", "group:food_bowl", "group:food_beetroot"}
	}
})
]]--
