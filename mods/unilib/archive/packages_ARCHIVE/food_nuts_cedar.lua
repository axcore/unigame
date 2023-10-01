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
minetest.register_craftitem("moretrees:cedar_nuts", {
	description = S("Roasted Cedar Cone Nuts"),
	inventory_image = "moretrees_cedar_nuts.png",
	on_use = minetest.item_eat(1),
})
minetest.register_craft({
	type = "cooking",
	output = "moretrees:cedar_nuts 4",
	recipe = "moretrees:cedar_cone",
})
]]--
