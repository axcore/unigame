---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bread
-- Code:    MIT
-- Media:   CC0/CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("bread:wholegraincarrotbread", {
    description = S("Wholegrain carrot bread"),
    inventory_image = "bread_wholegraincarrotbread.png",
    on_use = minetest.item_eat(8),
    groups = {food_bread = 1, flammable =2}
})
minetest.register_craft({
    type = "cooking",
    cooktime = 10,
    output = "bread:wholegraincarrotbread",
    recipe = "bread:wholegraincarrotbread_dough",
})
]]--
