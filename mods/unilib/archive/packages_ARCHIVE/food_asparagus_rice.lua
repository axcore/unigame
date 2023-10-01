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
minetest.register_node("cucina_vegana:asparagus_rice", {
	description = S("Asparagus on Rice (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_asparagus_rice.png"},
	inventory_image = "cucina_vegana_asparagus_rice.png",
	wield_image = "cucina_vegana_asparagus_rice.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:asparagus_rice",
	recipe = {
				{"cucina_vegana:asparagus", "group:food_rice", "group:food_butter"},
				{"", "group:food_plate", ""}
			},
			replacements = {
							{"group:food_rice", "cucina_vegana:bowl"},
						}
})

minetest.register_node("cucina_vegana:asparagus_rice_cooked", {
	description = S("Asparagus on Rice"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_asparagus_rice_cooked.png"},
	inventory_image = "cucina_vegana_asparagus_rice_cooked.png",
	wield_image = "cucina_vegana_asparagus_rice_cooked.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(6,  "cucina_vegana:plate"),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "cucina_vegana:asparagus_rice_cooked",
	recipe = "cucina_vegana:asparagus_rice"
})
]]--
