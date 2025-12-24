---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_goat_milk = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_goat_milk.init()

    return {
        description = "Goat's milk cheese",
        depends = "bucket_steel_with_milk_goat",
    }

end

function unilib.pkg.food_cheese_goat_milk.exec()

    unilib.register_craftitem("unilib:food_cheese_goat_milk", nil, mode, {
        -- Original to unimobs
        description = S("Goat's Milk Cheese"),
        inventory_image = "unilib_food_cheese_goat_milk.png",
        groups = {flammable = 2, food = 2, food_cheese = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cheese_goat_milk", 5),
    })
    unilib.register_craft({
        -- Original to unimobs
        type = "cooking",
        output = "unilib:food_cheese_goat_milk",
        recipe = "unilib:bucket_steel_with_milk_goat",
        cooktime = 4,
        replacements = {
            {"unilib:bucket_steel_with_milk_goat", "unilib:bucket_steel_empty"},
        },
    })

end
