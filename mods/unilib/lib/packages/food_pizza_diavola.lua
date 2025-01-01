---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_diavola = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_diavola.init()

    return {
        description = "Diavola pizza",
        depends = {"fruit_olive", "ingredient_dough_pizza", "ingredient_sauce_tomato"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_pizza_diavola.exec()

    local c_chilli = "unilib:produce_chilli_normal_harvest"
    local c_dough = "unilib:ingredient_dough_pizza"
    local c_sauce = "unilib:ingredient_sauce_tomato"

    unilib.register_craftitem("unilib:food_pizza_diavola_raw", nil, mode, {
        -- Original to unilib
        description = S("Uncooked Diavola Pizza"),
        inventory_image = "unilib_food_pizza_diavola_raw.png",

        stack_max = 1,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_pizza_diavola_raw",
        recipe = {
            {"unilib:fruit_olive", "group:food_cheese", "unilib:fruit_olive"},
            {c_chilli, c_sauce, c_chilli},
            {"group:food_pork_raw", c_dough, "group:food_pork_raw"},
        },
    })
    unilib.register_external_ingredient("unilib:food_pizza_diavola", {
        "group:food_pork_raw",
    })

    unilib.register_craftitem("unilib:food_pizza_diavola_slice", nil, mode, {
        -- Original to unilib
        description = S("Diavola Pizza Slice"),
        inventory_image = "unilib_food_pizza_diavola_slice.png",

        stack_max = 8,

        -- N.B. Replace player effects in original code, with a simple health boost
        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_diavola_slice", 10),
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:food_pizza_diavola_slice 8",
        recipe = "unilib:food_pizza_diavola_raw",
        cooktime = 30,
    })

end
