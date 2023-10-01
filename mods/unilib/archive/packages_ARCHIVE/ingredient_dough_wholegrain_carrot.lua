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
minetest.register_craftitem("bread:wholegraincarrotbread_dough", {
    description = S("Wholegrain carrot bread dough"),
    inventory_image = "bread_wholegraincarrotbread_dough.png",
})
minetest.register_craft({
    output = "bread:wholegraincarrotbread_dough",
    recipe = {
				{"", "farming:sunflower_seeds_toasted", ""},
                {"farming:flour", "farming:glass_water", "farming:carrot"}
            },
})
]]--
