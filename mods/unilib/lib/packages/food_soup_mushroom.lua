---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_mushroom = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_mushroom.init()

    return {
        description = "Mushroom soup",
        depends = "utensil_bowl_wooden",
        suggested = {
            "mushroom_brown",                   -- group:food_mushroom
        },
    }

end

function unilib.pkg.food_soup_mushroom.exec()

    unilib.register_craftitem("unilib:food_soup_mushroom", "ethereal:mushroom_soup", mode, {
        -- From ethereal:mushroom_soup
        description = S("Mushroom Soup"),
        inventory_image = "unilib_food_soup_mushroom.png",
        -- N.B. no food_mushroom in original code
        groups = {drink = 1, food_mushroom_soup = 1},

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_soup_mushroom", 5, "unilib:utensil_bowl_wooden"
        )
    })
    unilib.register_craft({
        -- From ethereal:mushroom_soup
        output = "unilib:food_soup_mushroom",
        recipe = {
            {"group:food_mushroom"},
            {"group:food_mushroom"},
            {"unilib:utensil_bowl_wooden"},
        },
    })

end
