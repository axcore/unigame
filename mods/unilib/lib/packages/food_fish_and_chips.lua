---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fish_and_chips = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fish_and_chips.init()

    return {
        description = "Fish and chips",
        depends = {"ingredient_fish_basic", "utensil_tray_baking"},
        suggested = {
            "produce_potato_normal",            -- group:food_potato
        },
    }

end

function unilib.pkg.food_fish_and_chips.exec()

    unilib.register_craftitem("unilib:food_fish_and_chips", "ethereal:fish_n_chips", mode, {
        -- From ethereal:fish_n_chips
        description = S("Fish and Chips"),
        inventory_image = "unilib_food_fish_and_chips.png",
        -- N.B. food_fish = 1, food_fish_and_chips = 1 not in original code
        groups = {flammable = 2, food_fish = 1, food_fish_and_chips = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_fish_and_chips", 6),
    })
    unilib.register_craft({
        -- From ethereal:fish_n_chips
        output = "unilib:food_fish_and_chips",
        recipe = {
            {"unilib:utensil_tray_baking", "group:food_fish_cookable", "group:food_potato"},
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

end
