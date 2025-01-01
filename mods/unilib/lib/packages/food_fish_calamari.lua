---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fish_calamari = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fish_calamari.init()

    return {
        description = "Calamari",
        depends = {"ingredient_fish_basic", "utensil_board_cutting", "utensil_skillet_normal"},
        suggested = {
            "ingredient_flour_ordinary",        -- group:food_flour
        },
    }

end

function unilib.pkg.food_fish_calamari.exec()

    unilib.register_craftitem("unilib:food_fish_calamari_raw", "ethereal:calamari_raw", mode, {
        -- From ethereal:calamari_raw
        description = S("Raw Calamari"),
        inventory_image = "unilib_food_fish_calamari_raw.png",
        groups = {flammable = 2},

        on_use = unilib.cuisine.eat_on_use("unilib:food_fish_calamari_raw", -2),
    })
    unilib.register_craft({
        -- From ethereal:calamari_raw
        output = "unilib:food_fish_calamari_raw 2",
        recipe = {
            {"unilib:utensil_board_cutting", "unilib:ingredient_fish_squid"},
        },
        replacements = {
            {"unilib:utensil_board_cutting", "unilib:utensil_board_cutting"},
        },
    })

    unilib.register_craftitem(
        -- From ethereal:calamari_cooked
        "unilib:food_fish_calamari_cooked",
        "ethereal:calamari_cooked",
        mode,
        {
            description = S("Calamari"),
            inventory_image = "unilib_food_fish_calamari_cooked.png",
            -- N.B. food_calamari = 1, food_fish = 1 not in original code
            groups = {flammable = 2, food_calamari = 1, food_fish = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_fish_calamari_cooked", 5),
        }
    )
    unilib.register_craft({
        -- From ethereal:calamari_cooked
        output = "unilib:food_fish_calamari_cooked",
        -- N.B. Original code used unilib:ingredient_flour_ordinary
        recipe = {
            {"unilib:utensil_skillet_normal", "unilib:food_fish_calamari_raw", "group:food_flour"},
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })

end
