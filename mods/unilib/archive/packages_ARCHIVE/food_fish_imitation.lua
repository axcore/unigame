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
minetest.register_craftitem("cucina_vegana:imitation_fish", {
	description = S("Imitation Fish"),
	groups = {food = 1, food_fish = 1, food_vegan = 1, eatable = 1},
	inventory_image = "cucina_vegana_imitation_fish.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "cucina_vegana:imitation_fish",
	recipe = {
				{"group:dye,color_blue","cucina_vegana:tofu", "group:dye,color_blue"},
				{"cucina_vegana:tofu","cucina_vegana:tofu", "cucina_vegana:tofu"},
				{"","cucina_vegana:tofu", ""},

			},
})
]]--
