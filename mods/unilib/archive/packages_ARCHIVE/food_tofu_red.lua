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
minetest.register_craftitem("cucina_vegana:tofu", {
	description = S("Tofu (raw)"),
	inventory_image = "cucina_vegana_tofu.png",
	groups = {flammable = 1, food = 1, eatable = 1, food_vegan = 1},
	on_use = minetest.item_eat(2),
})
minetest.register_craft({
	output = "cucina_vegana:tofu",
	recipe = {
			{"cucina_vegana:soy", "cucina_vegana:soy", "cucina_vegana:soy"},
			{"cucina_vegana:soy", "cucina_vegana:soy", "cucina_vegana:soy"},
			{"cucina_vegana:soy", "cucina_vegana:soy", "cucina_vegana:soy"},
		},
})

minetest.register_craftitem("cucina_vegana:tofu_cooked", {
	description = S("Tofu"),
	inventory_image = "cucina_vegana_tofu_cooked.png",
	groups = {flammable = 1, food = 1, eatable = 1, food_vegan = 1, food_tofu = 1},
	on_use = minetest.item_eat(3),
})
minetest.register_craft({
	type = "cooking",
	output = "cucina_vegana:tofu_cooked",
	recipe = "cucina_vegana:tofu",
	cooktime = 5,
})
if(minetest.get_modpath("technic")) then

	-- Support Compressor
	local compressor_recipes = {
                    {"cucina_vegana:soy 8", "cucina_vegana:tofu"},
                }

	for _, data in pairs(compressor_recipes) do

		technic.register_compressor_recipe({input = {data[1]}, output = data[2]})

	end

end
]]--
