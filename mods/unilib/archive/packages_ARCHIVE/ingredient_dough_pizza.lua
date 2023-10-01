---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("cucina_vegana:pizza_dough", {
	description = S("Pizzadough"),
	inventory_image = "cucina_vegana_pizza_dough.png",
	groups = {food = 1, pizza_dough = 1},
})
minetest.register_craft({
	output = "cucina_vegana:pizza_dough",
	recipe = {	{"group:food_milk", "group:food_oil", "group:food_cheese"},
				{"group:food_flour", "group:food_flour", "group:food_flour"}
			},
    replacements = {
                    {"group:food_milk", "vessels:glass_bottle"},
                    {"group:food_oil", "vessels:glass_bottle"},
                    }
})
]]--
