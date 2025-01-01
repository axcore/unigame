---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_quattro_formaggi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_quattro_formaggi.init()

    return {
        description = "Quattro formaggi pizza",
        depends = {
            "food_cheese_gorgonzola",
            "food_cheese_mozzarella",
            "food_cheese_parmesan",
            "food_cheese_ricotta",
            "ingredient_dough_pizza",
            "ingredient_sauce_tomato",
        },
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_pizza_quattro_formaggi.exec()

    local c_dough = "unilib:ingredient_dough_pizza"
    local c_sauce = "unilib:ingredient_sauce_tomato"

    unilib.register_craftitem("unilib:food_pizza_quattro_formaggi_raw", nil, mode, {
        -- Original to unilib
        description = S("Uncooked Quattro Formaggi Pizza"),
        inventory_image = "unilib_food_pizza_quattro_formaggi_raw.png",

        stack_max = 1,
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_pizza_quattro_formaggi_raw",
        recipe = {
            {"group:food_cheese", "group:food_cheese", "group:food_cheese"},
            {"unilib:food_cheese_gorgonzola", c_sauce, "unilib:food_cheese_mozzarella"},
            {"unilib:food_cheese_parmesan", c_dough, "unilib:food_cheese_ricotta"},
        },
    })

    unilib.register_craftitem("unilib:food_pizza_quattro_formaggi_slice", nil, mode, {
        -- Original to unilib
        description = S("Quattro Formaggi Pizza Slice"),
        inventory_image = "unilib_food_pizza_quattro_formaggi_slice.png",

        stack_max = 8,

        -- N.B. Replace player effects in original code, with a simple health boost
        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_quattro_formaggi_slice", 10),
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:food_pizza_quattro_formaggi_slice 8",
        recipe = "unilib:food_pizza_quattro_formaggi_raw",
        cooktime = 30,
    })

end
