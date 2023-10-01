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
minetest.register_node("cucina_vegana:salad_hollandaise", {
	description = S("Salad Bowl Hollandaise"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_salad_hollandaise.png"},
	inventory_image = "cucina_vegana_salad_hollandaise.png",
	wield_image = "cucina_vegana_salad_hollandaise.png",
	on_use = minetest.item_eat(5, "cucina_vegana:bowl"),
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_vegan = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:salad_hollandaise",
	recipe = {
				{"cucina_vegana:sauce_hollandaise", "cucina_vegana:salad_bowl", ""}
			},
            replacements = {
                            {"cucina_vegana:sauce_hollandaise", "vessels:glass_bottle"},
                           }
})
minetest.register_craft({
	output = "cucina_vegana:salad_hollandaise",
	recipe = {	{"cucina_vegana:parsley", "cucina_vegana:lettuce", "cucina_vegana:chives"},
				{"cucina_vegana:sauce_hollandaise", "group:food_oil", ""},
				{"", "group:food_bowl", ""}
			},
    replacements = {
                {"group:food_oil", "vessels:glass_bottle"},
				{"cucina_vegana:sauce_hollandaise", "vessels:glass_bottle"}
			}

})
]]--
