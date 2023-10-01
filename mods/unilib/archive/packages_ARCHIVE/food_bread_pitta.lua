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
minetest.register_craftitem("bread:pita", {
    description = S("Pita bread"),
    inventory_image = "bread_pita.png",
    on_use = minetest.item_eat(4),
    groups = {food_bread = 1, flammable =2}
})
minetest.register_craft({
    type = "cooking",
    cooktime = 10,
    output = "bread:pita",
    recipe = "bread:pita_dough",
})
]]--
