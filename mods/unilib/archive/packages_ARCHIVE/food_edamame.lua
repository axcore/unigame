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
minetest.register_node("cucina_vegana:edamame", {
	description = S("Edamame (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_edamame.png"},
	inventory_image = "cucina_vegana_edamame.png",
	wield_image = "cucina_vegana_edamame.png",
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
	output = "cucina_vegana:edamame",
	recipe = {	{"cucina_vegana:rosemary", "group:seed_soy", "cucina_vegana:peanut"},
                {"group:seed_soy", "group:seed_soy", "group:seed_soy"},
				{"", "group:food_plate", ""}
			}
})

minetest.register_node("cucina_vegana:edamame_cooked", {
	description = S("Edamame"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_edamame_cooked.png"},
	inventory_image = "cucina_vegana_edamame_cooked.png",
	wield_image = "cucina_vegana_edamame_cooked.png",
	on_use = minetest.item_eat(4, "cucina_vegana:plate"),
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
	type = "cooking",
	cooktime = 7,
	output = "cucina_vegana:edamame_cooked",
	recipe = "cucina_vegana:edamame"
})
]]--
