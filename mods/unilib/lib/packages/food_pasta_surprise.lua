---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pasta_surprise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pasta_surprise.init()

    return {
        description = "Pasta surprise",
        depends = {
            "food_cheese_parmesan",
            "food_pasta",
            "ingredient_oil_olive",
            "utensil_bowl_wooden",
        },
        suggested = {
            "produce_chilli_normal",            -- group:food_chilli_pepper
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_pasta_surprise.exec()

    unilib.register_craftitem("unilib:food_pasta_surprise", nil, mode, {
        -- Original to unilib
        description = S("Pasta Surprise"),
        inventory_image = "unilib_food_pasta_surprise.png",
        groups = {food_pasta = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pasta_surprise", 20),
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_pasta_surprise",
        recipe = {
            {
                "unilib:food_pasta",
                "group:food_tomato",
                "group:food_chilli_pepper",
            },
            {
                "unilib:ingredient_oil_olive",
                "unilib:utensil_tray_baking",
                "unilib:food_cheese_parmesan",
            },
        },
        replacements = {
            {"unilib:food_pasta", "unilib:utensil_bowl_wooden"},
        },
    })

end
