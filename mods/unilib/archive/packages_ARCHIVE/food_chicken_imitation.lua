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
minetest.register_craftitem("cucina_vegana:imitation_poultry", {
	description = S("Imitation poultry"),
	groups = {food = 1, food_bird = 1, food_vegan = 1},
	inventory_image = "cucina_vegana_imitation_poultry.png",
})
minetest.register_craft({
	output = "cucina_vegana:imitation_poultry",
	recipe = {	{"cucina_vegana:tofu", "", "group:dye,color_yellow"},
				{"", "cucina_vegana:tofu", ""},
				{"cucina_vegana:tofu", "cucina_vegana:tofu", "cucina_vegana:tofu"}
			},
})
]]--
