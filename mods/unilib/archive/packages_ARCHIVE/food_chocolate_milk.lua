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
minetest.register_craftitem("cacaotree:milk_chocolate", {
    description = S("Milk Chocolate"),
    inventory_image = "cacaotree_milk_choco.png",
    on_use = minetest.item_eat(4),
    groups = {flammable = 2, food = 2, food_chocolate = 1},
})
minetest.register_craft({
	type = "shapeless",
	output = "cacaotree:milk_chocolate 6",
	recipe = {"cacaotree:cocoa_powder", "group:milk_bucket"},
	replacements = {{"group:milk_bucket", "bucket:bucket_empty"}},
})
]]--
