---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_pizza = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_pizza.init()

    return {
        description = "Pizza dough",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.ingredient_dough_pizza.exec()

    unilib.register_craftitem("unilib:ingredient_dough_pizza", "cucina_vegana:pizza_dough", mode, {
        -- From cucina_vegana:pizza_dough
        description = S("Pizza Dough"),
        inventory_image = "unilib_ingredient_dough_pizza.png",
        groups = {food = 1, pizza_dough = 1},
    })
    unilib.register_craft({
        -- From cucina_vegana:pizza_dough
        output = "unilib:ingredient_dough_pizza",
        recipe = {
            {"group:food_milk", "group:food_oil", "group:food_cheese"},
            {"group:food_flour", "group:food_flour", "group:food_flour"},
        },
        replacements = {
            {"group:food_milk", "unilib:vessel_bottle_glass_empty"},
            {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
