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
minetest.register_node("cucina_vegana:asparagus_soup", {
	description = S("Asparagus Soup (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_asparagus_soup.png"},
	inventory_image = "cucina_vegana_asparagus_soup.png",
	wield_image = "cucina_vegana_asparagus_soup.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_soup = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:asparagus_soup",
	recipe = {	{"cucina_vegana:chives", "group:food_oil", "cucina_vegana:asparagus"},
				{"", "cucina_vegana:soy_milk", ""},
				{"", "group:food_plate", ""}
			},
			replacements = {{"group:food_milk", "vessels:glass_bottle"},
						   {"group:food_oil", "vessels:glass_bottle"},
						}
})

minetest.register_node("cucina_vegana:asparagus_soup_cooked", {
	description = S("Asparagus Soup"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_asparagus_soup_cooked.png"},
	inventory_image = "cucina_vegana_asparagus_soup_cooked.png",
	wield_image = "cucina_vegana_asparagus_soup_cooked.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(5,  "cucina_vegana:plate"),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "cucina_vegana:asparagus_soup_cooked",
	recipe = "cucina_vegana:asparagus_soup"
})
]]--
