---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_ham = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_ham.init()

    return {
        description = "Ham",
        depends = "ingredient_brine",
        suggested = {
            "food_honey_synthetic",             -- group:food_honey
        },
    }

end

function unilib.pkg.food_ham.exec()

    unilib.register_craftitem("unilib:food_ham_raw", "bbq:ham_raw", mode, {
        -- From bbq:ham_raw
        description = S("Raw Ham"),
        inventory_image = "unilib_food_ham_raw.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_ham_raw", 4),
    })
    unilib.register_craft({
        -- From bbq:ham_raw
        type = "shapeless",
        output = "unilib:food_ham_raw 2",
        recipe = {"unilib:ingredient_brine", "group:food_pork_raw", "group:food_honey"},
    })
    unilib.register_external_ingredient("unilib:food_ham_raw", {
        "group:food_pork_raw",                  -- Originally mobs:pork_raw
    })

    unilib.register_craftitem("unilib:food_ham", "bbq:ham", mode, {
        -- From bbq:ham
        description = S("Ham"),
        inventory_image = "unilib_food_ham.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_ham", 9),
    })
    unilib.register_craft({
        -- From bbq:ham
        type = "cooking",
        output = "unilib:food_ham",
        recipe = "unilib:food_ham_raw",
        cooktime = 10,
    })

end
