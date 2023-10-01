---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("better_farming:chilie_powder", {
	description = minetest.colorize("Red","Chilie Powder"),
	on_use = minetest.item_eat(-1),
	inventory_image = "chilie_powder.png",
})
minetest.register_craft({
	output = "better_farming:chilie_powder",
	recipe = {
		{"better_farming:chilie"},
	}
})
]]--
