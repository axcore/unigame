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
minetest.register_node("cucina_vegana:sauce_hollandaise", {
	description = S("Sauce Hollandaise"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_sauce_hollandaise.png"},
	inventory_image = "cucina_vegana_sauce_hollandaise.png",
	wield_image = "cucina_vegana_sauce_hollandaise.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(3, "vessels:glass_bottle"),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, food = 1, food_sauce = 1, food_vegan = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:sauce_hollandaise",
	recipe = {	{"cucina_vegana:parsley", "group:food_butter", "cucina_vegana:rosemary"},
				{"", "cucina_vegana:soy_milk", ""},
				{"", "vessels:glass_bottle", ""}
			},
    replacements = {
            {"cucina_vegana:soy_milk", "vessels:glass_bottle"}
                   }
})
]]--
