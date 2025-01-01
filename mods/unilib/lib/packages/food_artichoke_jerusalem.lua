---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo (20241118 update)
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_artichoke_jerusalem = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_artichoke_jerusalem.init()

    return {
        description = "Jerusalem artichokes",
        depends = {"utensil_bowl_wooden", "utensil_skillet_normal"},
        suggested = {
            "ingredient_butter_normal",         -- group:food_butter
            "ingredient_salt_normal",           -- group:food_salt
            "produce_artichoke",                -- group:food_artichoke
            "produce_garlic_normal",            -- group:food_garlic_clove
            "produce_soy_normal",               -- group:food_soy
        },
    }

end

function unilib.pkg.food_artichoke_jerusalem.exec()

    unilib.register_craftitem(
        -- From farming:jerusalem_artichokes
        "unilib:food_artichoke_jerusalem",
        "farming:jerusalem_artichokes",
        mode,
        {
            description = S("Jerusalem Artichokes"),
            inventory_image = "unilib_food_artichoke_jerusalem.png",
            -- N.B. no food_jerusalem_artichokes = 1 in original code
            groups = {flammable = 2, food_jerusalem_artichokes = 1},

            on_use = unilib.cuisine.eat_on_use(
                "unilib:food_artichoke_jerusalem", 11, "unilib:utensil_bowl_wooden"
            ),
        }
    )
    unilib.register_craft({
        -- From farming:jerusalem_artichokes
        output = "unilib:food_artichoke_jerusalem",
        -- N.B. "group:food_skillet", "group:food_bowl" in original code
        recipe = {
            {"group:food_artichoke", "group:food_garlic_clove", "group:food_artichoke"},
            {"group:food_soy", "group:food_salt", "group:food_soy"},
            {"group:food_butter", "unilib:utensil_skillet_normal", "unilib:utensil_bowl_wooden"},
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })

end
