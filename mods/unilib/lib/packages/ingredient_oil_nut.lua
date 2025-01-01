---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_nut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_nut.init()

    return {
        description = "Nut oil",
        notes = "An alternative source of oil, in case other sources are not available. Produced" ..
                " in a milk churn",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "food_nuts_cedar",                  -- group:food_nut
        },
    }

end

function unilib.pkg.ingredient_oil_nut.exec()

    unilib.register_craftitem("unilib:ingredient_oil_nut", "cheese:nut_oil", mode, {
        -- From cheese:nut_oil
        description = S("Nut Oil"),
        inventory_image = "unilib_ingredient_oil_nut.png",
        groups = {food_oil = 1, vegan_alternative = 1, vessel = 1},
    })
    unilib.register_craft({
        -- From cheese:nut_oil
        type = "shapeless",
        output = "unilib:ingredient_oil_nut",
        recipe = {
            "unilib:vessel_bottle_glass_empty",
            "group:food_nut",
            "group:food_nut",
            "group:food_nut",
            "group:food_nut",
            "group:food_nut",
        },
    })

end
