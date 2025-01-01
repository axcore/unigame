---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_date_nut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_date_nut.init()

    return {
        description = "Date and nut cake",
        notes = "An exceptional food item due to its highly concentrated nature (32 food units)",
        depends = "ingredient_batter_date_nut",
    }

end

function unilib.pkg.food_cake_date_nut.exec()

    unilib.register_craftitem("unilib:food_cake_date_nut", "moretrees:date_nut_cake", mode, {
        -- From moretrees:date_nut_cake
        description = S("Date and Nut Cake"),
        inventory_image = "unilib_food_cake_date_nut.png",
        -- N.B. No groups in original code
        groups = {food_date_nut_cake = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cake_date_nut", 32),
    })
    unilib.register_craft({
        -- From moretrees:date_nut_cake
        type = "cooking",
        output = "unilib:food_cake_date_nut",
        recipe = "unilib:ingredient_batter_date_nut",
    })

end
