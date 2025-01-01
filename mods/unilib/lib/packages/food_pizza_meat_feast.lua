---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_meat_feast = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_meat_feast.init()

    return {
        description = "Meat feast pizza",
        depends = {"ingredient_dough_pizza", "ingredient_sauce_tomato"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_pizza_meat_feast.exec()

    local c_dough = "unilib:ingredient_dough_pizza"
    local c_sauce = "unilib:ingredient_sauce_tomato"

    unilib.register_craftitem("unilib:food_pizza_meat_feast_raw", nil, mode, {
        -- Original to unilib
        description = S("Uncooked Meat Feast Pizza"),
        inventory_image = "unilib_food_pizza_meat_feast_raw.png",

        stack_max = 1,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_pizza_meat_feast_raw",
        recipe = {
            {"group:food_chicken_raw", "group:food_cheese", "group:food_chicken_raw"},
            {"group:food_mutton_raw", c_sauce, "group:food_mutton_raw"},
            {"group:food_pork_raw", c_dough, "group:food_pork_raw"},
        },
    })
    unilib.register_external_ingredient("unilib:food_pizza_meat_feast_raw", {
        "group:food_chicken_raw",
        "group:food_mutton_raw",
        "group:food_pork_raw",
    })

    unilib.register_craftitem("unilib:food_pizza_meat_feast_slice", nil, mode, {
        -- Original to unilib
        description = S("Meat Feast Pizza Slice"),
        inventory_image = "unilib_food_pizza_meat_feast_slice.png",

        stack_max = 8,

        -- N.B. Replace player effects in original code, with a simple health boost
        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_meat_feast_slice", 10),
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:food_pizza_meat_feast_slice 8",
        recipe = "unilib:food_pizza_meat_feast_raw",
        cooktime = 30,
    })

end
