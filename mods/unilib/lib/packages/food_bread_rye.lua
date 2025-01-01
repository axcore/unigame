---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_rye = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_rye.init()

    return {
        description = "Rye bread",
        depends = "ingredient_flour_rye",
    }

end

function unilib.pkg.food_bread_rye.exec()

    unilib.register_craftitem("unilib:food_bread_rye", "grains:rye_bread", mode, {
        -- From grains:rye_bread
        description = S("Rye Bread"),
        inventory_image = "unilib_food_bread_rye.png",
        -- N.B. food_bread not in original code
        groups = {flammable = 2, food_bread = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_rye", 5),
    })
    unilib.register_craft({
        -- From grains:rye_bread
        type = "cooking",
        output = "unilib:food_bread_rye",
        recipe = "unilib:ingredient_flour_rye",
        cooktime = 15,
    })
    unilib.register_craft({
        -- From grains:rye_bread
        type = "fuel",
        recipe = "unilib:food_bread_rye",
        burntime = 1,
    })

end
