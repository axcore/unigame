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
minetest.register_craftitem("moretrees:date_nut_bar", {
	description = S("Date-nut energy bar"),
	inventory_image = "moretrees_date_nut_bar.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	type = "shapeless",
	output = "moretrees:date_nut_bar 8",
	recipe = {"moretrees:date_nut_cake"},
})
]]--
