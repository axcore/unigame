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
minetest.register_node("cucina_vegana:pizza_vegana_raw", {
	description = S("Pizza Vegana (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_pizza_vegana_raw.png"},
	inventory_image = "cucina_vegana_pizza_vegana_raw.png",
	wield_image = "cucina_vegana_pizza_vegana_raw.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1},
})
minetest.register_craft({
	output = "cucina_vegana:pizza_vegana_raw",
	recipe = {	{"", "cucina_vegana:sauce_hollandaise", ""},
				{"cucina_vegana:asparagus", "cucina_vegana:lettuce", "cucina_vegana:rosemary"},
                {"", "group:pizza_dough", ""}
			},
    replacements = {
                        {"cucina_vegana:sauce_hollandaise", "vessels:glass_bottle"},
                    }

})

minetest.register_node("cucina_vegana:pizza_vegana", {
	description = S("Pizza Vegana"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_pizza_vegana.png"},
	inventory_image = "cucina_vegana_pizza_vegana.png",
	wield_image = "cucina_vegana_pizza_vegana.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(6),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, eatable = 1},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 18,
	output = "cucina_vegana:pizza_vegana",
	recipe = "cucina_vegana:pizza_vegana_raw"
})
]]--
