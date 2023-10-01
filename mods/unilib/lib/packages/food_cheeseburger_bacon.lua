---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheeseburger_bacon = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheeseburger_bacon.init()

    return {
        description = "Bacon cheeseburger",
        depends = {"food_bacon", "food_bread_ordinary", "food_hamburger"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
        },
    }

end

function unilib.pkg.food_cheeseburger_bacon.exec()

    unilib.register_craftitem("unilib:food_cheeseburger_bacon", "bbq:bacon_cheeseburger", mode, {
        -- From bbq:bacon_cheeseburger
        description = S("Bacon Cheeseburger"),
        inventory_image = "unilib_food_cheeseburger_bacon.png",
        -- N.B. No groups in original code
        groups = {food_burger = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cheeseburger_bacon", 9),
    })
    unilib.register_craft({
        -- From bbq:bacon_cheeseburger
        type = "shapeless",
        output = "unilib:food_cheeseburger_bacon 3",
        recipe = {
            "unilib:food_bread_ordinary",
            "unilib:food_bacon",
            "unilib:food_hamburger_patty",
            "group:food_cheese",
        },
    })

end
