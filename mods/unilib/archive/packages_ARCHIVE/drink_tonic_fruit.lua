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
if cheese.ethereal and cheese.farming then
	minetest.register_craftitem("cheese:fruit_tonic", {
		description = S("Fruit Tonic"),
		inventory_image = "fruit_tonic.png",
		on_use = minetest.item_eat(8, "vessels:glass_bottle"),
		groups = {food = 8, vessel = 1},
	})
	minetest.register_craft({
		output = "cheese:fruit_tonic",
		recipe = {
			{"group:food_grapes", "group:food_orange", "group:food_apple"},
			{"group:food_apple", "group:food_grapes", "group:food_orange"},
			{"vessels:glass_bottle", "cheese:whey", "vessels:glass_bottle"},
		},
	})
end -- if ingredients are present, apple:default, grapes:farming, orange:ethereal

]]--
