---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    bread
-- Code:    MIT
-- Media:   CC0/CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_pitta = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.bread.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_pitta.init()

    return {
        description = "Pitta bread",
        depends = "ingredient_dough_pitta",
    }

end

function unilib.pkg.food_bread_pitta.exec()

    unilib.register_craftitem("unilib:food_bread_pitta", "bread:pita", mode, {
        -- From bread:pita
        description = S("Pitta Bread"),
        inventory_image = "unilib_food_bread_pitta.png",
        groups = {flammable = 2, food_bread = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_pitta", 4),
    })
    unilib.register_craft({
        -- From bread:pita
        type = "cooking",
        output = "unilib:food_bread_pitta",
        recipe = "unilib:ingredient_dough_pitta",
        cooktime = 10,
    })

end
