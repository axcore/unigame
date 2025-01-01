---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_strawberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_strawberry.init()

    return {
        description = "Strawberry cake",
        depends = "ingredient_flour_ordinary",
        suggested = {
            "produce_strawberry_normal",        -- group:food_strawberry
        },
    }

end

function unilib.pkg.food_cake_strawberry.exec()

    local c_flour = "unilib:ingredient_flour_ordinary"

    unilib.register_craftitem(
        -- From better_farming:strawberry_cake
        "unilib:food_cake_strawberry",
        "better_farming:strawberry_cake",
        mode,
        {
            description = S("Strawberry Cake"),
            inventory_image = "unilib_food_cake_strawberry.png",

            on_use = unilib.cuisine.eat_on_use("unilib:food_cake_strawberry", 5),
    })
    unilib.register_craft({
        -- From better_farming:strawberry_cake
        output = "unilib:food_cake_strawberry",
        -- N.B. Original code used "better_farming:strawberry" and "animalia:chicken_egg_fried"
        recipe = {
            {"group:food_strawberry", "group:food_strawberry", "group:food_strawberry"},
            {"group:food_egg", c_flour, "group:food_egg"},
            {c_flour, c_flour, c_flour},
        },
    })
    unilib.register_external_ingredient("unilib:food_cake_strawberry", {
        "group:food_egg",                       -- Originally animalia:chicken_egg_fried
    })

end
