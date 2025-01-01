---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pizza
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_margherita = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pizza.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_margherita.init()

    return {
        description = "Margherita pizza",
        depends = {"ingredient_dough_pizza", "ingredient_sauce_tomato"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_pizza_margherita.exec()

    local c_dough = "unilib:ingredient_dough_pizza"
    local c_sauce = "unilib:ingredient_sauce_tomato"

    unilib.register_craftitem(
        -- From pizza:uncooked_margherita
        "unilib:food_pizza_margherita_raw",
        "pizza:uncooked_margherita",
        mode,
        {
            description = S("Uncooked Margherita Pizza"),
            inventory_image = "unilib_food_pizza_margherita_raw.png",

            stack_max = 1,
        }
    )
    unilib.register_craft({
        -- From pizza:uncooked_margherita
        output = "unilib:food_pizza_margherita_raw",
        recipe = {
            {"group:food_cheese"},
            {c_sauce},
            {c_dough},
        },
    })

    unilib.register_craftitem("unilib:food_pizza_margherita_slice", "pizza:margherita", mode, {
        -- From pizza:margherita
        description = S("Margherita Pizza Slice"),
        inventory_image = "unilib_food_pizza_margherita_slice.png",

        stack_max = 8,

        -- N.B. 10 in original code; reduced to 5 because other pizzas using this design have 9
        --      ingredients
        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_margherita_slice", 5),
    })
    unilib.register_craft({
        -- From pizza:margherita
        type = "cooking",
        output = "unilib:food_pizza_margherita_slice 8",
        recipe = "unilib:food_pizza_margherita_raw",
        cooktime = 30,
    })

end
