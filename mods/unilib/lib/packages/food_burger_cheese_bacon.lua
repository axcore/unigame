---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_burger_cheese_bacon = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_burger_cheese_bacon.init()

    return {
        description = "Bacon cheeseburger",
        depends = {"food_bacon", "food_bread_ordinary", "food_burger_hamburger"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_burger_cheese_bacon.exec()

    unilib.register_craftitem("unilib:food_burger_cheese_bacon", "bbq:bacon_cheeseburger", mode, {
        -- From bbq:bacon_cheeseburger
        description = S("Bacon Cheeseburger"),
        inventory_image = "unilib_food_burger_cheese_bacon.png",
        -- N.B. No groups in original code
        groups = {food_burger = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_burger_cheese_bacon", 9),
    })
    unilib.register_craft({
        -- From bbq:bacon_cheeseburger
        type = "shapeless",
        output = "unilib:food_burger_cheese_bacon 3",
        recipe = {
            "unilib:food_bread_ordinary",
            "unilib:food_bacon",
            "unilib:food_burger_hamburger_patty",
            "group:food_cheese",
        },
    })

end
