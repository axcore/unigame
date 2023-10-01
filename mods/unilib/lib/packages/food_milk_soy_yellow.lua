---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_milk_soy_yellow = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_milk_soy_yellow.init()

    return {
        description = "Yellow soybean milk",
        depends = "ingredient_soy_yellow_water",
    }

end

function unilib.pkg.food_milk_soy_yellow.exec()

    unilib.register_craftitem("unilib:food_milk_soy_yellow", "cropocalypse:soy_milk", mode, {
        -- From cropocalypse:soy_milk
        description = S("Yellow Soybean Milk"),
        inventory_image = "unilib_food_milk_soy_yellow.png",
        groups = {flammable = 1, food_soy_milk = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_milk_soy_yellow", 4),
    })
    unilib.register_craft({
        -- From cropocalypse:soy_milk
        type = "cooking",
        output = "unilib:food_milk_soy_yellow",
        recipe = "unilib:ingredient_soy_yellow_water",
    })

end
