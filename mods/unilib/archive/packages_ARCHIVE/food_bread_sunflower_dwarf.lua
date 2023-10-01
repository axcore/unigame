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
minetest.register_craftitem("cucina_vegana:sunflower_seeds_bread", {
	description = S("Sunflower Seeds Bread"),
	groups = {food = 1, food_bread = 1, eatable = 1},
	inventory_image = "cucina_vegana_sunflower_seeds_bread.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "cucina_vegana:sunflower_seeds_bread",
	recipe = "cucina_vegana:sunflower_seeds_dough"
})
if(minetest.get_modpath("technic")) then

    -- Support Alloy_Furnace
    local alloy_recipes = {
    {"farming:flour 3",                      "cucina_vegana:sunflower_seeds","cucina_vegana:sunflower_seeds_bread"},
    {"cucina_vegana:sunflower_seeds_flour 3","cucina_vegana:sunflower_seeds","cucina_vegana:sunflower_seeds_bread"},
    {"cucina_vegana:rice_flour 3",           "cucina_vegana:sunflower_seeds","cucina_vegana:sunflower_seeds_bread"},
    }

    for _, data in pairs(alloy_recipes) do
        technic.register_alloy_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
    end

end
]]--
