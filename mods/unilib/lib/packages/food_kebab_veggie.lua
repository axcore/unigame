---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_kebab_veggie = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_kebab_veggie.init()

    return {
        description = "Veggie kebab",
        depends = {"item_stick_ordinary", "mushroom_brown"},
        suggested = {
            "food_pepper",                      -- group:food_pepper
            "produce_potato_normal",            -- group:food_potato
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_kebab_veggie.exec()

    unilib.register_craftitem("unilib:food_kebab_veggie_raw", "bbq:veggie_kebab_raw", mode, {
        -- From bbq:veggie_kebab_raw
        description = S("Raw Veggie Kebab"),
        inventory_image = "unilib_food_kebab_veggie_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_kebab_veggie_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:veggie_kebab_raw
        type = "shapeless",
        output = "unilib:food_kebab_veggie_raw 2",
        recipe = {
            "group:food_pepper",
            "group:food_potato",
            "group:food_tomato",
            "unilib:mushroom_brown",
            "unilib:item_stick_ordinary",
        },
    })

    unilib.register_craftitem("unilib:food_kebab_veggie", "bbq:veggie_kebab", mode, {
        -- From bbq:veggie_kebab
        description = S("Veggie Kebab"),
        inventory_image = "unilib_food_kebab_veggie.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_kebab_veggie", 8),
    })
    unilib.register_craft({
        -- From bbq:veggie_kebab
        type = "cooking",
        output = "unilib:food_kebab_veggie",
        recipe = "unilib:food_kebab_veggie_raw",
        cooktime = 8,
    })

end
