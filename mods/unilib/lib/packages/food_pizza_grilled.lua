---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_grilled = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_grilled.init()

    return {
        description = "Grilled pizza",
        depends = {"crop_wheat", "food_tomato_grilled", "ingredient_yeast", "mushroom_brown"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "food_pepper",                      -- group:food_pepper
            "ingredient_salt_normal",           -- group:food_salt
        },
    }

end

function unilib.pkg.food_pizza_grilled.exec()

    unilib.register_craftitem("unilib:food_pizza_grilled_raw", "bbq:grilled_pizza_raw", mode, {
        -- From bbq:grilled_pizza_raw
        description = S("Raw Grilled Pizza"),
        inventory_image = "unilib_food_pizza_grilled_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_grilled_raw", 5),
    })
    unilib.register_craft({
        -- From bbq:grilled_pizza_raw
        type = "shapeless",
        output = "unilib:food_pizza_grilled_raw 3",
        recipe = {
            "group:food_cheese",
            "group:food_pepper",
            "unilib:food_tomato_grilled",
            "unilib:mushroom_brown",
            "group:food_salt",
            "unilib:crop_wheat_harvest",
            "unilib:ingredient_yeast",
        },
    })

    unilib.register_craftitem("unilib:food_pizza_grilled", "bbq:grilled_pizza", mode, {
        -- From bbq:grilled_pizza
        description = S("Grilled Pizza"),
        inventory_image = "unilib_food_pizza_grilled.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_grilled", 8),
    })
    unilib.register_craft({
        -- From bbq:grilled_pizza
        type = "cooking",
        output = "unilib:food_pizza_grilled",
        recipe = "unilib:food_pizza_grilled_raw",
        cooktime = 5,
    })

end
