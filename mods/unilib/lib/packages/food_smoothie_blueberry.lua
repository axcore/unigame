---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_smoothie_blueberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_smoothie_blueberry.init()

    return {
        description = "Blueberry smoothie",
        depends = {"snow_ordinary", "vessel_glass_empty"},
        suggested = {
            "fruit_blueberry_ordinary",         -- group:food_blueberries
        },
    }

end

function unilib.pkg.food_smoothie_blueberry.exec()

    unilib.register_craftitem("unilib:food_smoothie_blueberry", nil, mode, {
        -- Original to unilib, based on farming:smoothie_raspberry
        description = S("Blueberry Smoothie"),
        inventory_image = "unilib_food_smoothie_blueberry.png",
        groups = {drink = 1, food_blueberry_smoothie = 1, vessel = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_smoothie_blueberry", 2, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- Original to unilib, based on farming:smoothie_raspberry
        output = "unilib:food_smoothie_blueberry",
        recipe = {
            {"unilib:snow_ordinary"},
            {"group:food_blueberries"},
            {"unilib:vessel_glass_empty"},
        },
    })

end
