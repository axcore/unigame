---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_beef_teriyaki = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_beef_teriyaki.init()

    return {
        description = "Teriyaki beef",
        depends = {
            "utensil_bowl_wooden",
            "utensil_saucepan_normal",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "ingredient_cornstarch",            -- group:food_gelatin
            "ingredient_sauce_soy",             -- group:food_soy_sauce
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_cabbage_normal",           -- group:food_cabbage
            "produce_garlic_normal",            -- group:food_garlic_clove
        },
    }

end

function unilib.pkg.food_beef_teriyaki.exec()

    unilib.register_craftitem("unilib:food_beef_teriyaki", "ethereal:teriyaki_beef", mode, {
        -- From ethereal:teriyaki_beef
        description = S("Teriyaki Beef"),
        inventory_image = "unilib_food_beef_teriyaki.png",
        -- N.B. No groups in original code
        groups = {food_teriyaki_beef = 1},

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_beef_teriyaki", 12, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From ethereal:teriyaki_beef
        output = "unilib:food_beef_teriyaki",
        recipe = {
            {"group:food_meat_raw", "group:food_sugar", "group:food_soy_sauce"},
            {"group:food_garlic_clove", "unilib:utensil_saucepan_normal", "group:food_gelatin"},
            {"group:food_cabbage", "group:food_rice", "unilib:utensil_bowl_wooden"},
        },
        replacements = {
            {"group:food_soy_sauce", "unilib:vessel_bottle_glass_empty"},
            {"unilib:utensil_saucepan_normal", "unilib:utensil_saucepan_normal"},
        },
    })
    unilib.register_external_ingredient("unilib:food_beef_teriyaki", {
        "group:food_meat_raw",                  -- Originally group:food_meat_raw
    })

end
