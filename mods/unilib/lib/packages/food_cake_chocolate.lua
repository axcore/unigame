---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cool_trees/cacaotree
-- Code:    GPLv3
-- Media:   GPLv3
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_chocolate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cacaotree.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_chocolate.init()

    return {
        description = "Chocolate cake",
        depends = {"crop_wheat", "ingredient_cocoa_normal"},
    }

end

function unilib.pkg.food_cake_chocolate.exec()

    local c_cocoa = "unilib:ingredient_cocoa_normal_powder"

    unilib.register_craftitem("unilib:food_cake_chocolate", "cacaotree:choco_cake", mode, {
        -- From cacaotree:choco_cake
        description = S("Chocolate Cake"),
        inventory_image = "unilib_food_cake_chocolate.png",
        groups = {flammable = 2, food = 2, food_chocolate = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cake_chocolate", 7),
    })
    unilib.register_craft({
        -- From cacaotree:choco_cake
        type = "shapeless",
        output = "unilib:food_cake_chocolate",
        recipe = {c_cocoa, "group:food_egg", "unilib:crop_wheat_harvest"},
    })
    unilib.register_external_ingredient("unilib:food_cake_chocolate", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
