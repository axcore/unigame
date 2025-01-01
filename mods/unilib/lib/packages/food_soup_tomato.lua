---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_tomato = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_tomato.init()

    return {
        description = "Tomato soup",
        depends = "utensil_bowl_wooden",
        suggested = {
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.food_soup_tomato.exec()

    unilib.register_craftitem("unilib:food_soup_tomato", "farming:tomato_soup", mode, {
        -- From farming:tomato_soup
        description = S("Tomato Soup"),
        inventory_image = "unilib_food_soup_tomato.png",
        -- N.B. no food_tomato_soup in original code
        groups = {flammable = 2, food_tomato_soup = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_soup_tomato", 8, "unilib:utensil_bowl_wooden"
        ),
    })
    unilib.register_craft({
        -- From farming:tomato_soup
        output = "unilib:food_soup_tomato",
        recipe = {
            {"group:food_tomato"},
            {"group:food_tomato"},
            {"unilib:utensil_bowl_wooden"},
        },
    })

end
