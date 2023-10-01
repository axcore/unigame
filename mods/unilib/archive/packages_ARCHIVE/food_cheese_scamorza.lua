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
minetest.register_craftitem("cheese:scamorza", { -- less hunger, unless cooked aka "smoked"
	description = S("Scamorza"),
	inventory_image = "scamorza.png",
	on_use = minetest.item_eat(4),
	groups = {food = 4, food_cheese = 1},
})
minetest.register_craft({
	output = "cheese:scamorza 4",
	recipe = {
		{"", "cheese:stretched_cheese", ""},
		{"cheese:stretched_cheese", "cheese:stretched_cheese", ""},
		{"cheese:stretched_cheese", "cheese:stretched_cheese", ""},
	}
})

minetest.register_craftitem("cheese:smoked_scamorza", {
	description = S("Smoked Scamorza"),
	inventory_image = "smoked_scamorza.png",
	on_use = minetest.item_eat(7),
	groups = {food = 7, food_cheese = 1},
})
minetest.register_craft({
	type = "cooking",
	output = "cheese:smoked_scamorza",
	recipe = "cheese:scamorza",
	cooktime = 11,
})
]]--
