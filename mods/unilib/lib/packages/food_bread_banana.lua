---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_banana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_banana.init()

    return {
        description = "Banana bread",
        depends = "ingredient_dough_banana",
    }

end

function unilib.pkg.food_bread_banana.exec()

    unilib.register_craftitem("unilib:food_bread_banana", "ethereal:banana_bread", mode, {
        -- From ethereal:banana_bread
        description = S("Banana Bread"),
        inventory_image = "unilib_food_bread_banana.png",
        groups = {flammable = 2, food_bread = 1},

        wield_image = "unilib_food_bread_banana.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_banana", 6),
    })
    unilib.register_craft({
        -- From ethereal:banana_dough
        type = "cooking",
        output = "unilib:food_bread_banana",
        recipe = "unilib:ingredient_dough_banana",
        cooktime = 14,
    })

end
