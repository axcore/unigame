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
minetest.register_craftitem("moretrees:spruce_nuts", {
	description = S("Roasted Spruce Cone Nuts"),
	inventory_image = "moretrees_spruce_nuts.png",
	on_use = minetest.item_eat(1),
})
minetest.register_craft({
	type = "cooking",
	output = "moretrees:spruce_nuts 4",
	recipe = "moretrees:spruce_cone",
})
]]--
