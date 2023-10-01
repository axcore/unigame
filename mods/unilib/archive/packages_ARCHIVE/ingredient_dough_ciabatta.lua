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
minetest.register_craftitem("cucina_vegana:ciabatta_dough", {
	description = S("Ciabatta dough"),
	inventory_image = "cucina_vegana_ciabatta_dough.png",
	groups = {food = 1, bread_dough = 1},
})
minetest.register_craft({
	output = "cucina_vegana:ciabatta_dough",
	recipe = {	{"cucina_vegana:soy_milk", "cucina_vegana:sunflower_seeds_oil", ""},
				{"group:food_flour", "cucina_vegana:rosemary", ""}
			},
    replacements = {
                        {"cucina_vegana:soy_milk", "vessels:drinking_glass"},
                        {"cucina_vegana:sunflower_seeds_oil", "vessels:glass_bottle"},
                    }
})
]]--
