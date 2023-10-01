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
minetest.register_craftitem("cucina_vegana:sunflower_seeds_dough", {
    description = S("Sunflower Seeds Dough"),
    groups = {food = 1, food_vegan = 1, eatable = 1, bread_dough = 1},
    inventory_image = "cucina_vegana_sunflower_seeds_dough.png",
    on_use = minetest.item_eat(2),
})
minetest.register_craft({
	output = "cucina_vegana:sunflower_seeds_dough",
	recipe = {	{"", "cucina_vegana:sunflower_seeds", ""},
				{"farming:flour", "farming:flour", "farming:flour"}
			}
})
minetest.register_craft({
	output = "cucina_vegana:sunflower_seeds_dough",
	recipe = {	{"", "cucina_vegana:sunflower_seeds", ""},
				{"group:food_flour", "group:food_flour", "group:food_flour"}
			}
})
]]--
