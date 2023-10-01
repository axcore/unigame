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
minetest.register_craftitem("moretrees:acorn_muffin", {
	description = S("Acorn Muffin"),
	inventory_image = "moretrees_acorn_muffin.png",
	on_use = minetest.item_eat(4),
})
minetest.register_craft({
	type = "cooking",
	output = "moretrees:acorn_muffin 4",
	recipe = "moretrees:acorn_muffin_batter",
})
]]--
