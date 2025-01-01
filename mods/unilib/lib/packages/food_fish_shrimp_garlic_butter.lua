---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fish_shrimp_garlic_butter = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fish_shrimp_garlic_butter.init()

    return {
        description = "Garlic butter shrimp",
        depends = {"fruit_lemon", "ingredient_fish_basic", "utensil_skillet_normal"},
        suggested = {
            "ingredient_butter_normal",         -- group:food_butter
            "produce_garlic_normal",            -- group:food_garlic_clove
        },
    }

end

function unilib.pkg.food_fish_shrimp_garlic_butter.exec()

    local c_fish = "unilib:ingredient_fish_shrimp"

    unilib.register_craftitem(
        -- From ethereal:garlic_shrimp
        "unilib:food_fish_shrimp_garlic_butter",
        "ethereal:garlic_shrimp",
        mode,
        {
            description = S("Garlic Butter Shrimp"),
            inventory_image = "unilib_food_fish_shrimp_garlic_butter.png",
            -- N.B. food_fish = 1, food_shrimp = 1 not in original code
            groups = {flammable = 2, food_fish = 1, food_shrimp = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_fish_shrimp_garlic_butter", 6),
        }
    )
    unilib.register_craft({
        -- From ethereal:garlic_shrimp
        output = "unilib:food_fish_shrimp_garlic_butter",
        recipe = {
            {"unilib:utensil_skillet_normal", c_fish, c_fish},
            {"group:food_butter", "group:food_garlic_clove", "unilib:fruit_lemon"},
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })

end
