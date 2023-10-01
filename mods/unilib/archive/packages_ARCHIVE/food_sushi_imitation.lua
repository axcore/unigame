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
minetest.register_craftitem("cucina_vegana:vegan_sushi", {
	description = S("Vegan Sushi"),
	groups = {food = 1, food_vegan = 1, eatable = 1},
	inventory_image = "cucina_vegana_vegan_sushi.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	output = "cucina_vegana:vegan_sushi",
	recipe = {	{"cucina_vegana:imitation_fish", "cucina_vegana:bowl_rice", ""},
				{"default:papyrus", "", ""}
			},
	replacements = {
		{"cucina_vegana:bowl_rice", "cucina_vegana:bowl"}
	}
})

local nodes = { { name = "default:sand_with_kelp",                                                 -- Name
            output = "cucina_vegana:vegan_sushi", 	                                            -- Output
            recipe = {	                                                                        -- Recipe
                        {"cucina_vegana:imitation_fish", "cucina_vegana:bowl_rice", ""},
                        {"default:sand_with_kelp", "", ""}
                    },
            repclaements = nil                                                                       -- Replacements
            },
        }


for node, value in ipairs(nodes) do
    if(minetest.registered_nodes[value.name] or minetest.registered_items[value.name]) then
        minetest.register_craft({
                                    output = value.output,
                                    recipe = value.recipe,
                                    replacements = value.replacements
                                })


    end

end
]]--
