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
minetest.register_node("cucina_vegana:sunflower_seeds_oil", {
	description = S("Bottle of Sunflower Seeds Oil"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_sunflower_seeds_oil.png"},
	inventory_image = "cucina_vegana_sunflower_seeds_oil.png",
	wield_image = "cucina_vegana_sunflower_seeds_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	on_use = minetest.item_eat(2, "vessels:glass_bottle"),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, food = 1, food_oil = 1, food_vegan = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:sunflower_seeds_oil",
	recipe = {	{"cucina_vegana:sunflower_seeds", "cucina_vegana:sunflower_seeds", "cucina_vegana:sunflower_seeds"},
				{"cucina_vegana:sunflower_seeds", "cucina_vegana:sunflower_seeds", "cucina_vegana:sunflower_seeds"},
				{"", "vessels:glass_bottle", ""}
			}
})
minetest.register_craft({
	type = "fuel",
	recipe = "cucina_vegana:sunflower_seeds_oil",
	burntime = 30,
	replacements = {{ "cucina_vegana:sunflower_seeds_oil", "vessels:glass_bottle"}}
})
if(minetest.get_modpath("technic")) then

	-- Support Compressor
	local compressor_recipes = {
                    {"cucina_vegana:sunflower_seeds 6", "cucina_vegana:sunflower_seeds_oil"},
                }

	for _, data in pairs(compressor_recipes) do

		technic.register_compressor_recipe({input = {data[1]}, output = data[2]})

	end

	-- Support Extractor
	local extractor_recipes = {
        {"cucina_vegana:sunflower_seeds 6", "cucina_vegana:sunflower_seeds_oil"},
	}

	for _, data in ipairs(extractor_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end
    
end
]]--
