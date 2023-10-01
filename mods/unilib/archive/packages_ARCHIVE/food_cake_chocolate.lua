---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("cacaotree:choco_cake", {
    description = S("Choco Cake"),
    inventory_image = "cacaotree_choco_cake.png",
    on_use = minetest.item_eat(7),
    groups = {flammable = 2, food = 2, food_chocolate = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cacaotree:choco_cake",
	recipe = {"cacaotree:cocoa_powder", "group:food_egg", "farming:wheat"},
})
]]--
