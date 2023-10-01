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
minetest.register_craftitem("cucina_vegana:blueberry_puree", {
	description = S("Blueberry purree"),
	inventory_image = "cucina_vegana_blueberry_puree.png",
	groups = {food = 1, food_blueberry = 1, food_berry = 1},
    on_use = minetest.item_eat(4)
})

local berries = {
                    "default:blueberries",
                    "farming:blueberries",
                    "bushes:blueberry"
                }

local press = {
                    "default:stone",
                    "default:cobble",
                    "default:desert_stone",
                    "default:desert_cobble"
            }

for bkey,berry in ipairs(berries) do
    for mkey,mat in ipairs(press) do
        minetest.register_craft({
                            output = "cucina_vegana:blueberry_puree",
                            recipe = {
                                        {mat, berry, berry},
                                        {mat, berry, berry},
                                        {mat, berry, berry},
                                    },
                            replacements = {
                                                {mat, mat .. " 3"}
                                            }
        }) 

    end 

end
        
if(minetest.get_modpath("technic")) then

	-- Support Compressor
	local compressor_recipes = {
                    {"default:blueberries 6", "cucina_vegana:blueberry_puree"},
                    {"farming:blueberries 6", "cucina_vegana:blueberry_puree"},
                    {"bushes:blueberry 6", "cucina_vegana:blueberry_puree"},
                }

	for _, data in pairs(compressor_recipes) do

		technic.register_compressor_recipe({input = {data[1]}, output = data[2]})

	end

end
]]--
