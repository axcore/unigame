---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_barley = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_barley.init()

    return {
        description = "Barley bread",
        depends = "ingredient_flour_barley",
    }

end

function unilib.pkg.food_bread_barley.exec()

    unilib.register_craftitem("unilib:food_bread_barley", "grains:barley_bread", mode, {
        -- From grains:barley_bread
        description = S("Barley Bread"),
        inventory_image = "unilib_food_bread_barley.png",
        -- N.B. food_bread not in original code
        groups = {flammable = 2, food_bread = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_barley", 5),
    })
    unilib.register_craft({
        -- From grains:barley_bread
        type = "cooking",
        output = "unilib:food_bread_barley",
        recipe = "unilib:ingredient_flour_barley",
        cooktime = 15,
    })
    unilib.register_craft({
        -- From grains:barley_bread
        type = "fuel",
        recipe = "unilib:food_bread_barley",
        burntime = 1,
    })

end
