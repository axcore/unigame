---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_ricotta = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_ricotta.init()

    return {
        description = "Ricotta cheese",
        depends = "ingredient_whey",
    }

end

function unilib.pkg.food_cheese_ricotta.exec()

    unilib.register_craftitem("unilib:food_cheese_ricotta", "cheese:ricotta", mode, {
        -- From cheese:ricotta
        description = S("Ricotta"),
        inventory_image = "unilib_food_cheese_ricotta.png",
        groups = {food_cheese = 1, food_cream = 1, food = 5},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cheese_ricotta", 5),
    })
    unilib.register_craft({
        -- From cheese:ricotta
        type = "cooking",
        output = "unilib:food_cheese_ricotta",
        recipe = "unilib:ingredient_whey",
        cooktime = 15,
    })

end
