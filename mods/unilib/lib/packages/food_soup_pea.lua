---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_pea = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_pea.init()

    return {
        description = "Pea soup",
        depends = "utensil_bowl_wooden",
        suggested = {
            "food_pea",                         -- group:food_peas
        },
    }

end

function unilib.pkg.food_soup_pea.exec()

    unilib.register_craftitem("unilib:food_soup_pea", "farming:pea_soup", mode, {
        -- From farming:pea_soup
        description = S("Pea Soup"),
        inventory_image = "unilib_food_soup_pea.png",
        -- N.B. no food_pea_soup in original code
        groups = {flammable = 2, food_pea_soup = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_soup_pea", 4, "unilib:utensil_bowl_wooden"),
    })
    unilib.register_craft({
        -- From farming:pea_soup
        output = "unilib:food_soup_pea",
        recipe = {
            {"group:food_peas"},
            {"group:food_peas"},
            {"unilib:utensil_bowl_wooden"},
        },
    })

end
