---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bbq
-- Code:    LGPL-2.1+
-- Media:   CC-BY-SA-3.0/CC-BY-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sauce_tomato = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bbq.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sauce_tomato.init()

    return {
        description = "Tomato sauce",
        suggested = {
            "produce_tomato_salad",             -- group:food_tomato
        },
    }

end

function unilib.pkg.ingredient_sauce_tomato.exec()

    unilib.register_craftitem("unilib:ingredient_sauce_tomato", "bbq:tomato_sauce", mode, {
        -- From bbq:tomato_sauce
        description = S("Tomato Sauce"),
        inventory_image = "unilib_ingredient_sauce_tomato.png",
        -- N.B. food_sauce = 1 not in original code
        groups = {food_sauce = 1, food_tomato_sauce = 1, vessel = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:ingredient_sauce_tomato", 2),
    })
    unilib.register_craft({
        -- From bbq:tomato_sauce
        type = "shapeless",
        output = "unilib:ingredient_sauce_tomato",
        recipe = {"group:food_tomato"},
    })

end
