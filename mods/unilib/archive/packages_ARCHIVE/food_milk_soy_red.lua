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
minetest.register_craftitem("cucina_vegana:soy_milk", {
	description = S("Soy Milk"),
	inventory_image = "cucina_vegana_soy_milk.png",
	groups = {flammable = 1, food = 1, food_milk = 1, eatable = 1, food_vegan = 1},
	on_use = minetest.item_eat(1, "vessels:drinking_glass"),
})
minetest.register_craft({
	output = "cucina_vegana:soy_milk",
	recipe = {
			{"cucina_vegana:soy", "cucina_vegana:soy", "cucina_vegana:soy"},
			{"", "cucina_vegana:soy", ""},
			{"", "vessels:drinking_glass", ""},
		},
})
if(minetest.get_modpath("technic")) then

	-- Support Extractor
	local extractor_recipes = {
        {"cucina_vegana:soy 4", "cucina_vegana:soy_milk"},
	}

	for _, data in ipairs(extractor_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end

end
]]--
