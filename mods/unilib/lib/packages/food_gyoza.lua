---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_gyoza = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_gyoza.init()

    return {
        description = "Gyoza",
        depends = "utensil_skillet_normal",
        suggested = {
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_salt_normal",           -- group:food_salt
            "produce_cabbage_normal",           -- group:food_cabbage
            "produce_garlic_normal",            -- group:food_garlic_clove
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_gyoza.exec()

    unilib.register_craftitem("unilib:food_gyoza", "farming:gyoza", mode, {
        -- From farming:gyoza
        description = S("Gyoza"),
        inventory_image = "unilib_food_gyoza.png",
        -- N.B. no food_gyoza in original code
        groups = {flammable = 2, food_gyoza = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_gyoza", 4),
    })
    unilib.register_craft({
        -- From farming:gyoza
        output = "unilib:food_gyoza 4",
        recipe = {
            {"group:food_cabbage", "group:food_garlic_clove", "group:food_onion"},
            {"group:food_meat_raw", "group:food_salt", "group:food_flour"},
            {"", "unilib:utensil_skillet_normal", ""},

        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })
    unilib.register_external_ingredient("unilib:food_gyoza", {
        "group:food_meat_raw",                  -- Originally group:food_meat_raw
    })

end
