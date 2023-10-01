---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_banana = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_banana.init()

    return {
        description = "Banana dough",
        suggested = {
            "fruit_banana",                     -- group:food_banana
            "ingredient_flour_ordinary",        -- group:food_flour
        },
    }

end

function unilib.pkg.ingredient_dough_banana.exec()

    unilib.register_craftitem("unilib:ingredient_dough_banana", "ethereal:banana_dough", mode, {
        -- From ethereal:banana_dough
        description = S("Banana Dough"),
        inventory_image = "unilib_ingredient_dough_banana.png"
    })
    unilib.register_craft({
        -- From ethereal:banana_dough
        output = "unilib:ingredient_dough_banana",
        recipe = {
            {"group:food_flour", "group:food_banana"},
        },
    })

end
