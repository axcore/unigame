---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("moretrees:date_nut_cake", {
	description = S("Date-nut cake"),
	inventory_image = "moretrees_date_nut_cake.png",
	on_use = minetest.item_eat(32),
})
minetest.register_craft({
	type = "cooking",
	output = "moretrees:date_nut_cake",
	recipe = "moretrees:date_nut_batter",
})
]]--
