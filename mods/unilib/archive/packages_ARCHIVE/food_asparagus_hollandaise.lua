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
minetest.register_node("cucina_vegana:asparagus_hollandaise", {
	description = S("Asparagus Hollandaise (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_asparagus_hollandaise.png"},
	inventory_image = "cucina_vegana_asparagus_hollandaise.png",
	wield_image = "cucina_vegana_asparagus_hollandaise.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:asparagus_hollandaise",
	recipe = {	{"cucina_vegana:asparagus", "cucina_vegana:sauce_hollandaise", "cucina_vegana:parsley"},
				{"", "group:food_plate", ""}
			},
			replacements = {	{"group:food_sauce", "vessels:glass_bottle"},
						}
})

minetest.register_node("cucina_vegana:asparagus_hollandaise_cooked", {
	description = S("Asparagus Hollandaise"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_asparagus_hollandaise_cooked.png"},
	inventory_image = "cucina_vegana_asparagus_hollandaise_cooked.png",
	wield_image = "cucina_vegana_asparagus_hollandaise_cooked.png",
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
	cooktime = 18,
	output = "cucina_vegana:asparagus_hollandaise_cooked",
	recipe = "cucina_vegana:asparagus_hollandaise"
})
]]--
