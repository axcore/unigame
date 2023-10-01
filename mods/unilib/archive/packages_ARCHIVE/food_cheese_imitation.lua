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
minetest.register_craftitem("cucina_vegana:imitation_cheese", {
	description = S("Imitation Cheese"),
	groups = {food = 1, food_cheese = 1, food_vegan = 1, eatable = 1},
	inventory_image = "cucina_vegana_imitation_cheese.png",
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	output = "cucina_vegana:imitation_cheese",
	recipe = {	{"group:dye,color_orange","cucina_vegana:imitation_butter", "cucina_vegana:imitation_butter"}
			},
})
]]--
