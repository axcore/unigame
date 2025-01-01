---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_smoothie_strawberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_smoothie_strawberry.init()

    return {
        description = "Strawberry smoothie",
        depends = {"snow_ordinary", "vessel_glass_empty"},
        suggested = {
            "produce_strawberry_normal",        -- group:food_strawberry
        },
    }

end

function unilib.pkg.food_smoothie_strawberry.exec()

    unilib.register_craftitem("unilib:food_smoothie_strawberry", nil, mode, {
        -- Original to unilib, based on farming:smoothie_raspberry
        description = S("Strawberry Smoothie"),
        inventory_image = "unilib_food_smoothie_strawberry.png",
        groups = {drink = 1, food_strawberry_smoothie = 1, vessel = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_smoothie_strawberry", 2, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- Original to unilib, based on farming:smoothie_raspberry
        output = "unilib:food_smoothie_strawberry",
        recipe = {
            {"unilib:snow_ordinary"},
            {"group:food_strawberry"},
            {"unilib:vessel_glass_empty"},
        },
    })

end
