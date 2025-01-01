---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_chicken_barbecued = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_chicken_barbecued.init()

    return {
        description = "Barbecued chicken pizza",
        depends = {"food_cheese_gouda", "ingredient_dough_pizza", "ingredient_sauce_tomato"},
        suggested = {
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_pizza_chicken_barbecued.exec()

    local c_chicken = "unilib:food_chicken_barbecued_raw"
    local c_dough = "unilib:ingredient_dough_pizza"
    local c_sauce = "unilib:ingredient_sauce_tomato"

    unilib.register_craftitem("unilib:food_pizza_chicken_barbecued_raw", nil, mode, {
        -- Original to unilib
        description = S("Uncooked Barbecued Chicken Pizza"),
        inventory_image = "unilib_food_pizza_chicken_barbecued_raw.png",

        stack_max = 1,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_pizza_chicken_barbecued_raw",
        recipe = {
            {"unilib:food_cheese_gouda", "group:food_cheese", "unilib:food_cheese_gouda"},
            {"group:food_onion", c_sauce, "group:food_onion"},
            {"group:food_chicken_raw", c_dough, "group:food_chicken_raw"},
        },
    })
    unilib.register_external_ingredient("unilib:food_chicken_barbecued_raw", {
        "group:food_chicken_raw",               -- Originally mobs:chicken_raw
    })

    unilib.register_craftitem("unilib:food_pizza_chicken_barbecued_slice", nil, mode, {
        -- Original to unilib
        description = S("Barbecued Chicken Pizza Slice"),
        inventory_image = "unilib_food_pizza_chicken_barbecued_slice.png",

        stack_max = 8,

        -- N.B. Replace player effects in original code, with a simple health boost
        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_chicken_barbecued_slice", 10),
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:food_pizza_chicken_barbecued_slice 8",
        recipe = "unilib:food_pizza_chicken_barbecued_raw",
        cooktime = 30,
    })

end
