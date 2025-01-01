---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_carrot = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_carrot.init()

    return {
        description = "Carrot cake",
        depends = {"food_sliced_carrot", "ingredient_flour_ordinary"},
    }

end

function unilib.pkg.food_cake_carrot.exec()

    unilib.register_craftitem("unilib:food_cake_carrot", "cropocalypse:carrot_cake", mode, {
        -- From cropocalypse:carrot_cake
        description = S("Carrot Cake"),
        inventory_image = "unilib_food_cake_carrot.png",
        groups = {flammable = 1, food_carrot_cake = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cake_carrot", 7),
    })
    unilib.register_craft({
        -- From cropocalypse:carrot_cake
        type = "shapeless",
        output = "unilib:food_cake_carrot",
        recipe = {
            "unilib:ingredient_flour_ordinary",
            "unilib:ingredient_flour_ordinary",
            "unilib:ingredient_sugar_beet",
            "unilib:food_sliced_carrot",
            "unilib:food_sliced_carrot",
            "unilib:food_sliced_carrot",
            "unilib:food_milk_soy_yellow",
        },
    })

end
