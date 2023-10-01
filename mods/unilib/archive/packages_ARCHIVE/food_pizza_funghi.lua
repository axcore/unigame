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
minetest.register_node("cucina_vegana:pizza_funghi_raw", {
	description = S("Pizza Funghi (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_pizza_funghi_raw.png"},
	inventory_image = "cucina_vegana_pizza_funghi_raw.png",
	wield_image = "cucina_vegana_pizza_funghi_raw.png",
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
	output = "cucina_vegana:pizza_funghi_raw",
	recipe = {	{"", "group:food_oil", "cucina_vegana:rosemary"},
				{"flowers:mushroom_brown", "cucina_vegana:imitation_meat", "flowers:mushroom_brown"},
                {"", "group:pizza_dough", ""}
			},
    replacements = {
                        {"group:food_oil", "vessels:glass_bottle"},
                    }

})

minetest.register_node("cucina_vegana:pizza_funghi", {
	description = S("Pizza Funghi"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_pizza_funghi.png"},
	inventory_image = "cucina_vegana_pizza_funghi.png",
	wield_image = "cucina_vegana_pizza_funghi.png",
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
	output = "cucina_vegana:pizza_funghi",
	recipe = "cucina_vegana:pizza_funghi_raw"
})
]]--
