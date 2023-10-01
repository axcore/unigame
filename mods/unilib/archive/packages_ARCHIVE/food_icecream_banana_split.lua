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
if cheese.farming and (minetest.registered_items["cheese:ice_cream_base"] or
 											minetest.registered_items["cheese:vegan_ice_cream_base"]) then

	if cheese.ethereal or cheese.cv then
		minetest.register_craftitem("cheese:banana_split", {
			description = S("Banana split"),
			inventory_image = "banana_split.png",
			on_use = minetest.item_eat(15),
			groups = {food = 15, food_icecream = 1},
		})
		-- because of previous checks, at least a type of cream has been registered
		minetest.register_craft({
			output = "cheese:banana_split",
			recipe = {
				{"", "group:food_cream", ""},
				{"", "cheese:neapolitan_ice_cream", ""},
				{"", "group:food_banana", ""},
			},
		})
	end -- if ethereal or cucina_vegana, where bananas are from

end
]]--
