---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chicken_barbecued = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chicken_barbecued.init()

    return {
        description = "Barbecued chicken",
        depends = {"ingredient_paprika_smoked", "ingredient_sauce_barbecue"},
    }

end

function unilib.pkg.food_chicken_barbecued.exec()

    unilib.register_craftitem("unilib:food_chicken_barbecued_raw", "bbq:bbq_chicken_raw", mode, {
        -- From bbq:bbq_chicken_raw
        description = S("Raw Barbecued Chicken"),
        inventory_image = "unilib_food_chicken_barbecued_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_chicken_barbecued_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:bbq_chicken_raw
        type = "shapeless",
        output = "unilib:food_chicken_barbecued_raw 3",
        recipe = {
            "unilib:ingredient_sauce_barbecue",
            "group:food_chicken_raw",
            "unilib:ingredient_paprika_smoked",
        },
    })
    unilib.register_external_ingredient("unilib:food_chicken_barbecued_raw", {
        "group:food_chicken_raw",               -- Originally mobs:chicken_raw
    })

    unilib.register_craftitem("unilib:food_chicken_barbecued", "bbq:bbq_chicken", mode, {
        -- From bbq:bbq_chicken
        description = S("Barbecued Chicken"),
        inventory_image = "unilib_food_chicken_barbecued.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_chicken_barbecued", 8),
    })
    unilib.register_craft({
        -- From bbq:bbq_chicken
        type = "cooking",
        output = "unilib:food_chicken_barbecued",
        recipe = "unilib:food_chicken_barbecued_raw",
        cooktime = 10,
    })

end
