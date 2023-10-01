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
minetest.register_craftitem("cucina_vegana:rice_flour", {
    description = S("Rice Flour"),
    groups = {food_vegan = 1, food_flour = 1},
    inventory_image = "cucina_vegana_rice_flour.png",
})
minetest.register_craft({
	output = "cucina_vegana:rice_flour",
	recipe = {	{"default:stone", "default:stone", "default:stone"},
				{"cucina_vegana:rice", "cucina_vegana:rice", "cucina_vegana:rice"},
                {"default:cobble", "default:cobble", "default:cobble"}
			},
    replacements = {
                {"default:stone", "default:stone 3"},
                {"default:cobble", "default:cobble 3"}
            }

})
minetest.register_craft({
	output = "cucina_vegana:rice_flour",
	recipe = {	{"default:desert_stone", "default:desert_stone", "default:desert_stone"},
				{"cucina_vegana:rice", "cucina_vegana:rice", "cucina_vegana:rice"},
                {"default:cobble", "default:cobble", "default:cobble"}
			},
    replacements = {
                {"default:desert_stone", "default:desert_stone 3"},
                {"default:cobble", "default:cobble 3"}
            }

})
minetest.register_craft({
	output = "cucina_vegana:rice_flour",
	recipe = {	{"default:desert_stone", "default:desert_stone", "default:desert_stone"},
				{"cucina_vegana:rice", "cucina_vegana:rice", "cucina_vegana:rice"},
                {"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"}
			},
    replacements = {
                {"default:desert_stone", "default:desert_stone 3"},
                {"default:desert_cobble", "default:desert_cobble 3"}
            }

})
minetest.register_craft({
	output = "cucina_vegana:rice_flour",
	recipe = {	{"default:stone", "default:stone", "default:stone"},
				{"cucina_vegana:rice", "cucina_vegana:rice", "cucina_vegana:rice"},
                {"default:desert_cobble", "default:desert_cobble", "default:desert_cobble"}
			},
    replacements = {
                {"default:stone", "default:stone 3"},
                {"default:cobble", "default:cobble 3"}
            }

})
if(minetest.get_modpath("technic")) then

    -- Support Grinder
    local grinder_recipes = {
        -- Other
        {"cucina_vegana:rice 3",                        "cucina_vegana:rice_flour"},
    }

    for _, data in pairs(grinder_recipes) do
        technic.register_grinder_recipe({input = {data[1]}, output = data[2]})

    end

end 
]]--
