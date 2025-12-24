---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheese_normal = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheese_normal.init()

    return {
        description = "Normal cheese",
        depends = "bucket_steel_with_milk_cow",
    }

end

function unilib.pkg.food_cheese_normal.exec()

    unilib.register_craftitem("unilib:food_cheese_normal", "petz:cheese", mode, {
        -- From petz:cheese
        description = S("Normal Cheese"),
        inventory_image = "unilib_food_cheese_normal.png",
        groups = {flammable = 2, food = 2, food_cheese = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_cheese_normal", 5),
    })
    unilib.register_craft({
        -- From petz:cheese
        type = "cooking",
        output = "unilib:food_cheese_normal",
        recipe = "unilib:bucket_steel_with_milk_cow",
        cooktime = 4,
        replacements = {
            {"unilib:bucket_steel_with_milk_cow", "unilib:bucket_steel_empty"},
        },
    })

end
