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
minetest.register_node("cucina_vegana:bowl_rice", {
	description = S("Bowl of Rice (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_bowl_rice.png"},
	inventory_image = "cucina_vegana_bowl_rice.png",
	wield_image = "cucina_vegana_bowl_rice.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, food_rice = 1, food_vegan = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:bowl_rice",
	recipe = {
				{"cucina_vegana:rice"},
				{"bucket:bucket_water"},
				{"group:food_bowl"},
			},
			replacements = {
							{"bucket:bucket_water", "bucket:bucket_empty"},
						}
})
minetest.register_craft({
	output = "cucina_vegana:bowl_rice",
	recipe = {
				{"cucina_vegana:rice"},
				{"bucket:bucket_river_water"},
				{"group:food_bowl"},
			},
			replacements = {
							{"bucket:bucket_river_water", "bucket:bucket_empty"},
						}
})

minetest.register_node("cucina_vegana:bowl_rice_cooked", {
	description = S("Bowl of Rice"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_bowl_rice_cooked.png"},
	inventory_image = "cucina_vegana_bowl_rice_cooked.png",
	wield_image = "cucina_vegana_bowl_rice_cooked.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(4,  "cucina_vegana:bowl"),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "cucina_vegana:bowl_rice_cooked",
	recipe = "cucina_vegana:bowl_rice"
})
]]--
