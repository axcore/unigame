---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pizza
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_mushroom_brown = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pizza.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_mushroom_brown.init()

    return {
        description = "Brown mushroom pizza",
        depends = {"ingredient_dough_pizza", "ingredient_sauce_tomato", "mushroom_brown"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_pizza_mushroom_brown.exec()

    unilib.register_craftitem(
        -- From pizza:uncooked_bmush
        "unilib:food_pizza_mushroom_brown_raw",
        "pizza:uncooked_bmush",
        mode,
        {
            description = S("Uncooked Brown Mushroom Pizza"),
            inventory_image = "unilib_food_pizza_mushroom_brown_raw.png",

            stack_max = 1,
        }
    )
    unilib.register_craft({
        -- From pizza:uncooked_bmush
        output = "unilib:food_pizza_mushroom_brown_raw",
        recipe = {
            {"unilib:mushroom_brown", "group:food_cheese", "unilib:mushroom_brown"},
            {"unilib:mushroom_brown", "unilib:ingredient_sauce_tomato", "unilib:mushroom_brown"},
            {"unilib:mushroom_brown", "unilib:ingredient_dough_pizza", "unilib:mushroom_brown"},
        },
    })

    unilib.register_craftitem("unilib:food_pizza_mushroom_brown_slice", "pizza:bmush", mode, {
        -- From pizza:bmush
        description = S("Brown Mushroom Pizza Slice"),
        inventory_image = "unilib_food_pizza_mushroom_brown_slice.png",

        stack_max = 8,

        -- N.B. Replace player effects in original code, with a simple health boost
        on_use = unilib.cuisine_eat_on_use("unilib:food_pizza_mushroom_brown_slice", 10),
    })
    unilib.register_craft({
        -- From pizza:bmush
        type = "cooking",
        output = "unilib:food_pizza_mushroom_brown_slice 8",
        recipe = "unilib:food_pizza_mushroom_brown_raw",
        cooktime = 30,
    })

end
