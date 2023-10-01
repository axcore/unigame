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
minetest.register_craftitem("cucina_vegana:imitation_butter", {
	description = S("Imitation Butter"),
	groups = {food = 1, food_butter = 1, food_vegan = 1, eatable = 1},
	inventory_image = "cucina_vegana_imitation_butter.png",
	on_use = minetest.item_eat(2),
})
minetest.register_craft({
	output = "cucina_vegana:imitation_butter",
	recipe = {	{"group:dye,color_yellow", "cucina_vegana:soy_milk",  "cucina_vegana:soy_milk"}
			},
			replacements = {
                            {"cucina_vegana:soy_milk", "vessels:drinking_glass"}
						}
})
]]--
