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
minetest.register_node("cucina_vegana:lettuce_oil", {
	description = S("Salad Oil"),
	drawtype = "plantlike",
	tiles = {"cucina_vegana_lettuce_oil.png"},
	inventory_image = "cucina_vegana_lettuce_oil.png",
	wield_image = "cucina_vegana_lettuce_oil.png",
	paramtype = "light",
	is_ground_content = false,
	on_use = minetest.item_eat(2, "vessels:glass_bottle"),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {dig_immediate = 3, attached_node = 1, food_oil = 1, food_vegan = 1, eatable = 1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	output = "cucina_vegana:lettuce_oil",
	recipe = {	{"group:seed_lettuce", "group:seed_lettuce", "group:seed_lettuce"},
				{"group:seed_lettuce", "group:seed_lettuce", "group:seed_lettuce"},
				{"", "vessels:glass_bottle", ""}
			}
})
minetest.register_craft({
	type = "fuel",
	recipe = "cucina_vegana:lettuce_oil",
	burntime = 30,
	replacements = {{ "cucina_vegana:lettuce_oil", "vessels:glass_bottle"}}
})

if(minetest.get_modpath("technic")) then

	-- Support Compressor
    if(cucina_vegana.farming_default) then
            table.insert(compressor_recipes,{"cucina_vegana:seed_lettuce 6", "cucina_vegana:lettuce_oil"})

    else
            table.insert(compressor_recipes,{"cucina_vegana:lettuce_seed 6", "cucina_vegana:lettuce_oil"})

    end -- if(cucina_vegana.farming_default

	for _, data in pairs(compressor_recipes) do

		technic.register_compressor_recipe({input = {data[1]}, output = data[2]})

	end


    -- Special Recipes with Seeds
    if(cucina_vegana.farming_default) then
        table.insert(extractor_recipes,{"cucina_vegana:seed_lettuce 6", "cucina_vegana:lettuce_oil"})

    else
        table.insert(extractor_recipes,{"cucina_vegana:lettuce_seed 6", "cucina_vegana:lettuce_oil"})

    end -- if(cucina_vegana.farming_default

	for _, data in ipairs(extractor_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end
    
end
]]--
