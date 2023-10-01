---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aqua_farming
-- Code:    GPL 3.0
-- Media:   CC-BY-3.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("aqua_farming:salt", {
        description = S("Sea Salt"),
        groups = {food = 1, food_vegan = 1, food_salt = 1},
        inventory_image = "aqua_farming_salt.png",
})
minetest.register_craft({
    type = "shapeless",
    output = "aqua_farming:salt",
    recipe = {name .. "_roasted_item"},
    replacements = {{name .. "_roasted_item", "dye:dark_green"}}
})
]]--
