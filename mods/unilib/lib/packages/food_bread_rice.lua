---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_rice = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_rice.init()

    return {
        description = "Rice bread",
        depends = "ingredient_flour_rice",
    }

end

function unilib.pkg.food_bread_rice.exec()

    unilib.register_craftitem("unilib:food_bread_rice", "farming:rice_bread", mode, {
        -- From farming:rice_bread
        description = S("Rice Bread"),
        inventory_image = "unilib_food_bread_rice.png",
        -- N.B. food_bread group not in original code, but is added by cucina_vegana overrides
        groups = {flammable = 2, food_bread = 1, food_rice_bread = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_rice", 5),
    })
    unilib.register_craft({
        -- From farming:rice_bread
        type = "cooking",
        output = "unilib:food_bread_rice",
        recipe = "unilib:ingredient_flour_rice",
        cooktime = 15,
    })
    unilib.register_craft({
        -- From farming:rice_bread
        type = "fuel",
        recipe = "unilib:food_bread_rice",
        burntime = 1,
    })

end
