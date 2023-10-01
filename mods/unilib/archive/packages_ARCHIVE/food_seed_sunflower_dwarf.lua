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
minetest.register_craftitem("cucina_vegana:sunflower_seeds", {
    description = S("Sunflower Seeds"),
    groups = {seed = 1, food = 1, eatable = 1, food_sunflower = 1},
    inventory_image = "cucina_vegana_sunflower_seeds.png",
    on_use = minetest.item_eat(1),
})
minetest.register_craft({
	type = "shapeless",
	output = "cucina_vegana:sunflower_seeds 4",
	recipe = {"flowers:sunflower"},
	replacements = {
		{"flowers:sunflower", "dye:yellow"}
	}
})
minetest.register_craft({
	type = "fuel",
	recipe = "cucina_vegana:sunflower_seeds",
	burntime = 2
})

minetest.register_craftitem("cucina_vegana:sunflower_seeds_roasted", {
	description = S("Roasted Sunflower Seeds"),
	groups = {food = 1, eatable = 1},
	inventory_image = "cucina_vegana_sunflower_seeds_roasted.png",
	on_use = minetest.item_eat(2),
})
minetest.register_craft({
	type = "cooking",
	output = "cucina_vegana:sunflower_seeds_roasted",
	recipe = "cucina_vegana:sunflower_seeds"
})
minetest.register_craft({
	type = "fuel",
	recipe = "cucina_vegana:sunflower_seeds_roasted",
	burntime = 2
})

if(minetest.get_modpath("technic")) then

	-- Support Centrifuge
	local centrifuge_recipes = {
					{ "flowers:sunflower",             "cucina_vegana:sunflower_seeds 4",       "dye:yellow"      },
                    { "cucina_vegana:sunflower",       "cucina_vegana:sunflower_seeds 4",       "dye:yellow"      },
				}

	for _, data in pairs(centrifuge_recipes) do

		technic.register_separating_recipe({ input = { data[1] }, output = { data[2], data[3], data[4] } })

	end

	-- Support Extractor
	local extractor_recipes = {
		{"flowers:sunflower", "cucina_vegana:sunflower_seeds 4"},
        {"cucina_vegana:sunflower", "cucina_vegana:sunflower_seeds 4"},
	}

	for _, data in ipairs(extractor_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end
    
end
]]--
