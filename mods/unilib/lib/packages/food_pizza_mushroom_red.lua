---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pizza
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_mushroom_red = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pizza.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_mushroom_red.init()

    return {
        description = "Red mushroom pizza",
        depends = {"ingredient_dough_pizza", "ingredient_sauce_tomato", "mushroom_red"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_pizza_mushroom_red.exec()

    local c_dough = "unilib:ingredient_dough_pizza"
    local c_sauce = "unilib:ingredient_sauce_tomato"

    unilib.register_craftitem(
        -- From pizza:uncooked_rmush
        "unilib:food_pizza_mushroom_red_raw",
        "pizza:uncooked_rmush",
        mode,
        {
            description = S("Uncooked Red Mushroom Pizza"),
            inventory_image = "unilib_food_pizza_mushroom_red_raw.png",

            stack_max = 1,
        }
    )
    unilib.register_craft({
        -- From pizza:uncooked_bmush
        output = "unilib:food_pizza_mushroom_red_raw",
        recipe = {
            {"unilib:mushroom_red", "group:food_cheese", "unilib:mushroom_red"},
            {"unilib:mushroom_red", c_sauce, "unilib:mushroom_red"},
            {"unilib:mushroom_red", c_dough, "unilib:mushroom_red"},
        },
    })

    unilib.register_craftitem("unilib:food_pizza_mushroom_red_slice", "pizza:rmush", mode, {
        -- From pizza:rmush
        description = S("Red Mushroom Pizza Slice"),
        inventory_image = "unilib_food_pizza_mushroom_red_slice.png",

        stack_max = 8,

        -- N.B. Replace player effects in original code, with a simple health penalty (only a small
        --      one, because the poisonous mushrooms have been cooked)
        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_mushroom_red_slice", -1),
    })
    unilib.register_craft({
        -- From pizza:rmush
        type = "cooking",
        output = "unilib:food_pizza_mushroom_red_slice 8",
        recipe = "unilib:food_pizza_mushroom_red_raw",
        cooktime = 30,
    })

end
