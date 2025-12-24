---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unimobs
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_yoghurt_camel_milk = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.unimobs.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_yoghurt_camel_milk.init()

    return {
        description = "Camel's milk yoghurt",
        depends = "bucket_steel_with_milk_camel",
    }

end

function unilib.pkg.food_yoghurt_camel_milk.exec()

    unilib.register_craftitem("unilib:food_yoghurt_camel_milk", nil, mode, {
        -- Original to unimobs
        description = S("Camel's Milk Yoghurt"),
        inventory_image = "unilib_food_yoghurt_camel_milk.png",
        groups = {flammable = 2, food = 2, food_yoghurt = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_yoghurt_camel_milk", 6),
    })
    unilib.register_craft({
        -- Original to unimobs
        type = "cooking",
        output = "unilib:food_yoghurt_camel_milk",
        recipe = "unilib:bucket_steel_with_milk_camel",
        cooktime = 20,
        replacements = {
            {"unilib:bucket_steel_with_milk_camel", "unilib:bucket_steel_empty"},
        },
    })

end
