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
minetest.register_craftitem("bread:pita_dough", {
    description = S("Pita dough"),
    inventory_image = "bread_pita_dough.png",
})
minetest.register_craft({
    output = "bread:pita_dough",
    recipe = {
                {"farming:flour", "farming:glass_water", "farming:flour"}
            },
})
]]--
