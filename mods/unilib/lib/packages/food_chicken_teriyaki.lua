---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chicken_teriyaki = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chicken_teriyaki.init()

    return {
        description = "Teriyaki chicken",
        depends = {"utensil_saucepan_normal", "vessel_bottle_glass_empty"},
        suggested = {
            "ingredient_cornstarch",            -- group:food_gelatin
            "ingredient_sauce_soy",             -- group:food_soy_sauce
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_garlic_normal",            -- group:food_garlic_clove
        },
    }

end

function unilib.pkg.food_chicken_teriyaki.exec()

    unilib.register_craftitem("unilib:food_chicken_teriyaki", "ethereal:teriyaki_chicken", mode, {
        -- From ethereal:teriyaki_chicken
        description = S("Teriyaki Chicken"),
        inventory_image = "unilib_food_chicken_teriyaki.png",
        -- N.B. food_chicken_teriyaki = 1 not in original code
        groups = {flammable = 2, food_chicken_teriyaki = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_chicken_teriyaki", 4),
    })
    unilib.register_craft({
        -- From ethereal:teriyaki_chicken
        output = "unilib:food_chicken_teriyaki 2",
        recipe = {
            {"group:food_chicken_raw", "group:food_sugar", "group:food_soy_sauce"},
            {"group:food_garlic_clove", "group:food_saucepan", "group:food_gelatin"},
        },
        replacements = {
            {"group:food_soy_sauce", "unilib:vessel_bottle_glass_empty"},
            {"unilib:utensil_saucepan_normal", "unilib:utensil_saucepan_normal"},
        },
    })
    unilib.register_external_ingredient("unilib:food_chicken_teriyaki", {
        "group:food_chicken_raw",               -- Originally group:food_chicken_raw
    })

end
