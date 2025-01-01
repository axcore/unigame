---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng (20241119 update)
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_salad_jellyfish = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_salad_jellyfish.init()

    return {
        description = "Jellyfish salad",
        depends = {"ingredient_fish_basic", "utensil_board_cutting"},
        suggested = {
            "produce_onion_normal",             -- group:food_onion
        },
    }

end

function unilib.pkg.food_salad_jellyfish.exec()

    local c_jellyfish = "unilib:ingredient_fish_jellyfish"

    unilib.register_craftitem("unilib:food_salad_jellyfish", "ethereal:jellyfish_salad", mode, {
        -- From ethereal:jellyfish_salad
        description = S("Jellyfish Salad"),
        inventory_image = "unilib_food_salad_jellyfish.png",
        -- N.B. food_fish = 1, food_jellyfish = 1 not in original code
        groups = {flammable = 2, food_fish = 1, food_jellyfish = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_salad_jellyfish", 6),
    })
    unilib.register_craft({
        -- From ethereal:jellyfish_salad
        output = "unilib:food_salad_jellyfishd",
        recipe = {
            {"unilib:utensil_board_cutting", c_jellyfish, "group:food_onion"},
        },
        replacements = {
            {"unilib:utensil_board_cutting", "unilib:utensil_board_cutting"},
        },
    })

end
