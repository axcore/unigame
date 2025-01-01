---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_ordinary.init()

    return {
        description = "Ordinary bread",
        depends = "ingredient_flour_ordinary",
    }

end

function unilib.pkg.food_bread_ordinary.exec()

    unilib.register_craftitem("unilib:food_bread_ordinary", "farming:bread", mode, {
        -- From farming:bread
        description = S("Ordinary Bread"),
        inventory_image = "unilib_food_bread_ordinary.png",
        groups = {flammable = 2, food_bread = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_ordinary", 5),
    })
    unilib.register_craft({
        -- From farming:bread
        type = "cooking",
        output = "unilib:food_bread_ordinary",
        recipe = "unilib:ingredient_flour_ordinary",

        cooktime = 15,
    })

end
