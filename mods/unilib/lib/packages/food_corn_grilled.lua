---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_corn_grilled = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_corn_grilled.init()

    return {
        description = "Grilled corn",
        depends = "ingredient_paprika_smoked",
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "produce_corn_normal",              -- group:food_corn
        },
    }

end

function unilib.pkg.food_corn_grilled.exec()

    unilib.register_craftitem("unilib:food_corn_grilled_raw", "bbq:grilled_corn_raw", mode, {
        -- From bbq:grilled_corn_raw
        description = S("Raw Grilled Corn"),
        inventory_image = "unilib_food_corn_grilled_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_corn_grilled_raw", 5),
    })
    unilib.register_craft({
        -- From bbq:grilled_corn_raw
        type = "shapeless",
        output = "unilib:food_corn_grilled_raw 2",
        recipe = {"group:food_cheese", "unilib:ingredient_paprika_smoked", "group:food_corn"}
    })

    unilib.register_craftitem("unilib:food_corn_grilled", "bbq:grilled_corn", mode, {
        -- From bbq:grilled_corn
        description = S("Grilled Corn"),
        inventory_image = "unilib_food_corn_grilled.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_corn_grilled", 8),
    })
    unilib.register_craft({
        -- From bbq:grilled_corn
        type = "cooking",
        output = "unilib:food_corn_grilled",
        recipe = "unilib:food_corn_grilled_raw",
        cooktime = 4,
    })

end
