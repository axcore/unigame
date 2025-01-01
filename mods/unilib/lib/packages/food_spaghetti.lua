---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_spaghetti = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_spaghetti.init()

    return {
        description = "Spaghetti",
        depends = "utensil_saucepan_normal",
        suggested = {
            "food_pasta",                       -- group:food_pasta
            "produce_garlic_normal",            -- group:food_garlic_clove
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_spaghetti.exec()

    unilib.register_craftitem("unilib:food_spaghetti", "farming:spaghetti", mode, {
        -- From farming:spaghetti
        description = S("Spaghetti"),
        inventory_image = "unilib_food_spaghetti.png",
        -- N.B. No groups in original code
        groups = {food_spaghetti = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_spaghetti", 8),
    })
    unilib.register_craft({
        -- From farming:spaghetti
        output = "unilib:food_spaghetti",
        recipe = {
            {"group:food_pasta", "unilib:utensil_saucepan_normal", "group:food_tomato"},
            {"group:food_garlic_clove", "group:food_garlic_clove", ""},
        },
        replacements = {
            {"unilib:utensil_saucepan_normal", "unilib:utensil_saucepan_normal"},
        },
    })

end
