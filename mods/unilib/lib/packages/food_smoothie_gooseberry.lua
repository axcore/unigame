---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_smoothie_gooseberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_smoothie_gooseberry.init()

    return {
        description = "Gooseberry smoothie",
        depends = {"bush_ornamental_gooseberry", "snow_ordinary", "vessel_glass_empty"},
    }

end

function unilib.pkg.food_smoothie_gooseberry.exec()

    unilib.register_craftitem("unilib:food_smoothie_gooseberry", nil, mode, {
        -- Original to unilib, based on farming:smoothie_raspberry
        description = S("Gooseberry Smoothie"),
        inventory_image = "unilib_food_smoothie_gooseberry.png",
        groups = {drink = 1, food_gooseberry_smoothie = 1, vessel = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_smoothie_gooseberry", 2, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- Original to unilib, based on farming:smoothie_raspberry
        output = "unilib:food_smoothie_gooseberry",
        recipe = {
            {"unilib:snow_ordinary"},
            {"unilib:fruit_gooseberry_picked"},
            {"unilib:vessel_glass_empty"},
        },
    })

end
