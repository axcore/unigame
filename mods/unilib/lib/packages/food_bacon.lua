---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bacon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bacon.init()

    return {
        description = "Bacon",
        depends = {"ingredient_brine", "ingredient_liquid_smoke"},
    }

end

function unilib.pkg.food_bacon.exec()

    unilib.register_craftitem("unilib:food_bacon_raw", "bbq:bacon_raw", mode, {
        -- From bbq:bacon_raw
        description = S("Raw Bacon"),
        inventory_image = "unilib_food_bacon_raw.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_bacon_raw", 3),
    })
    unilib.register_craft({
        -- From bbq:bacon_raw
        type = "shapeless",
        output = "unilib:food_bacon_raw 2",
        recipe = {
            "unilib:ingredient_liquid_smoke",
            "unilib:ingredient_brine",
            "group:food_pork_raw",
        },
    })
    unilib.register_external_ingredient("unilib:food_bacon_raw", {
        "group:food_pork_raw",                  -- Originally mobs:pork_raw
    })

    unilib.register_craftitem("unilib:food_bacon", "bbq:bacon", mode, {
        -- From bbq:bacon
        description = S("Bacon"),
        inventory_image = "unilib_food_bacon.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_bacon", 7),
    })
    unilib.register_craft({
        -- From bbq:bacon
        type = "cooking",
        output = "unilib:food_bacon",
        recipe = "unilib:food_bacon_raw",
        cooktime = 5,
    })

end
