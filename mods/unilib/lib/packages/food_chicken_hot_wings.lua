---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chicken_hot_wings = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chicken_hot_wings.init()

    return {
        description = "Chicken hot wings",
        depends = {"ingredient_paprika_smoked", "ingredient_sauce_hot"},
    }

end

function unilib.pkg.food_chicken_hot_wings.exec()

    unilib.register_craftitem("unilib:food_chicken_hot_wings_raw", "bbq:hot_wings_raw", mode, {
        -- From bbq:hot_wings_raw
        description = S("Raw Chicken Hot Wings"),
        inventory_image = "unilib_food_chicken_hot_wings_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_chicken_hot_wings_raw", 3),
    })
    unilib.register_craft({
        -- From bbq:hot_wings_raw
        type = "shapeless",
        output = "unilib:food_chicken_hot_wings_raw 3",
        recipe = {
            "unilib:ingredient_sauce_hot",
            "group:food_chicken_raw",
            "unilib:ingredient_paprika_smoked",
        },
    })
    unilib.register_external_ingredient("unilib:food_chicken_hot_wings_raw", {
        "group:food_chicken_raw",               -- Originally mobs:chicken_raw
    })

    unilib.register_craftitem("unilib:food_chicken_hot_wings", "bbq:hot_wings", mode, {
        -- From bbq:hot_wings
        description = S("Chicken Hot Wings"),
        inventory_image = "unilib_food_chicken_hot_wings.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_chicken_hot_wings", 8),
    })
    unilib.register_craft({
        -- From bbq:hot_wings
        type = "cooking",
        output = "unilib:food_chicken_hot_wings",
        recipe = "unilib:food_chicken_hot_wings_raw",
        cooktime = 7,
    })

end
