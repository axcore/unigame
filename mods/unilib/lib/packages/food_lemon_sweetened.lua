---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_lemon_sweetened = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_lemon_sweetened.init()

    return {
        description = "Sugar-coated lemon",
        depends = {"fruit_lemon", "utensil_tray_baking"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_lemon_sweetened.exec()

    unilib.register_craftitem("unilib:food_lemon_sweetened", "ethereal:candied_lemon", mode, {
        -- From ethereal:candied_lemon
        description = S("Sugar-Coated Lemon"),
        inventory_image = "unilib_food_lemon_sweetened.png",
        -- N.B. Use both original and adapted groups
        groups = {food_candied_lemon = 1, food_sweetened_lemon = 1},

        wield_image = "unilib_food_lemon_sweetened.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_lemon_sweetened", 5),
    })
    unilib.register_craft({
        -- From ethereal:candied_lemon
        output = "unilib:food_lemon_sweetened",
        recipe = {
            {"unilib:utensil_tray_baking", "unilib:fruit_lemon", "group:food_sugar"},
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

end
