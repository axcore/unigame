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

	minetest.register_craftitem("cheese:neapolitan_ice_cream", {
		description = S("Neapolitan Ice Cream"),
		inventory_image = "neapolitan_ice_cream.png",
		on_use = minetest.item_eat(11),
		groups = {food = 11, food_icecream = 1},
	})

	minetest.register_craft({
		output = "cheese:neapolitan_ice_cream 3",
		recipe = {
			{"", "", "group:food_strawberry"},
			{"farming:vanilla_extract", "group:food_chocolate", "group:food_strawberry"},
			{"group:food_icecream_base", "group:food_icecream_base", "group:food_icecream_base"},
		},
		replacements = {{"farming:vanilla_extract", "vessels:glass_bottle"} },
	})

	minetest.register_craft({
		output = "cheese:neapolitan_ice_cream 3",
		recipe = {
			{"", "", "group:food_strawberry"},
			{"farming:vanilla_extract", "farming:chocolate_dark", "group:food_strawberry"},
			{"group:food_icecream_base", "group:food_icecream_base", "group:food_icecream_base"},
		},
		replacements = {{"farming:vanilla_extract", "vessels:glass_bottle"} },
	})

end
]]--
