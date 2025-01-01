---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_veggie_supreme = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_veggie_supreme.init()

    return {
        description = "Veggie supreme pizza",
        depends = {
            "crop_tomato_cherry",
            "fruit_olive",
            "ingredient_dough_pizza",
            "ingredient_sauce_tomato",
        },
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "food_pepper",                      -- group:food_pepper
            "mushroom_brown",                   -- group:food_mushroom
            "produce_carrot_normal",            -- group:food_carrot
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_pizza_veggie_supreme.exec()

    local c_dough = "unilib:ingredient_dough_pizza"
    local c_sauce = "unilib:ingredient_sauce_tomato"

    unilib.register_craftitem("unilib:food_pizza_veggie_supreme_raw", nil, mode, {
        -- Original to unilib
        description = S("Uncooked Veggie Supreme Pizza"),
        inventory_image = "unilib_food_pizza_veggie_supreme_raw.png",

        stack_max = 1,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_pizza_veggie_supreme_raw",
        recipe = {
            {"group:food_pepper", "group:food_cheese", "group:food_onion"},
            {"unilib:fruit_olive", c_sauce, "unilib:crop_tomato_cherry_harvest"},
            {"group:food_carrot", c_dough, "group:food_mushroom"},
        },
    })

    unilib.register_craftitem("unilib:food_pizza_veggie_supreme_slice", nil, mode, {
        -- Original to unilib
        description = S("Veggie Supreme Pizza Slice"),
        inventory_image = "unilib_food_pizza_veggie_supreme_slice.png",

        stack_max = 8,

        -- N.B. Replace player effects in original code, with a simple health boost
        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_veggie_supreme_slice", 10),
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:food_pizza_veggie_supreme_slice 8",
        recipe = "unilib:food_pizza_veggie_supreme_raw",
        cooktime = 30,
    })

end
