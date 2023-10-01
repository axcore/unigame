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
minetest.register_node("cucina_vegana:fryer_raw", {
	description = S("Fryer (raw)"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_fryer_raw.png"},
	inventory_image = "cucina_vegana_fryer_raw.png",
	wield_image = "cucina_vegana_fryer_raw.png",
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
	output = "cucina_vegana:fryer_raw",
	recipe = {
				{"default:paper","", "default:paper"},
				{"cucina_vegana:parsley","cucina_vegana:molasses", "cucina_vegana:rosemary"},
				{"","cucina_vegana:imitation_poultry", ""},
			},
			replacements = {
							{"cucina_vegana:molasses", "vessels:drinking_glass"},
						}
})

minetest.register_node("cucina_vegana:fryer", {
	description = S("Fryer"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_fryer.png"},
	inventory_image = "cucina_vegana_fryer.png",
	wield_image = "cucina_vegana_fryer.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(8),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, eatable = 1},
})
minetest.register_craft({
	type = "cooking",
	cooktime = 25,
	output = "cucina_vegana:fryer",
	recipe = "cucina_vegana:fryer_raw"
})
]]--
