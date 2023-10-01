---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_oat = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_oat.init()

    return {
        description = "Oatbread",
        depends = "ingredient_flour_oat",
    }

end

function unilib.pkg.food_bread_oat.exec()

    unilib.register_craftitem("unilib:food_bread_oat", "grains:oat_bread", mode, {
        -- From grains:oat_bread
        description = S("Oatbread"),
        inventory_image = "unilib_food_bread_oat.png",
        -- N.B. food_bread not in original code
        groups = {flammable = 2, food_bread = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_oat", 5),
    })
    unilib.register_craft({
        -- From grains:oat_bread
        type = "cooking",
        output = "unilib:food_bread_oat",
        recipe = "unilib:ingredient_flour_oat",
        cooktime = 15,
    })
    unilib.register_craft({
        -- From grains:oat_bread
        type = "fuel",
        recipe = "unilib:food_bread_oat",
        burntime = 1,
    })

end
