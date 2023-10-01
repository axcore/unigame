---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
if cheese.moretrees or cheese.ethereal then
	minetest.register_craftitem("cheese:vegan_ice_cream_base", {
		description = S("Vegan Ice Cream"),
		inventory_image = "vegan_ice_cream_base.png",
		on_use = minetest.item_eat(3),
		groups = {vegan_alternative = 1, food = 5, food_icecream = 1, food_icecream_base = 1},
	})
	if cheese.cv then
		minetest.register_craft({
			type = "shapeless",
			output = "cheese:vegan_ice_cream_base 4",
			recipe = {"cucina_vegana:soy_milk", "cheese:coconut_cream", "cheese:coconut_cream",
								"group:food_sugar", "default:snow"},
			replacements = {{"cucina_vegana:soy_milk", "vessels:drinking_glass"} },
		})
	end
	minetest.register_craft({
		type = "shapeless",
		output = "cheese:vegan_ice_cream_base 4",
		recipe = {"group:food_coconut_milk", "group:food_coconut_milk", "cheese:coconut_cream",
							"cheese:coconut_cream", "group:food_sugar", "default:snow"},
		replacements = {{"group:food_coconut_milk", "vessels:drinking_glass"},
										{"group:food_coconut_milk", "vessels:drinking_glass"}},
	})
end
]]--
