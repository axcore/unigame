---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_smoothie_blackberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_smoothie_blackberry.init()

    return {
        description = "Blackberry smoothie",
        depends = {"snow_ordinary", "vessel_glass_empty"},
        suggested = {
            "produce_blackberry",               -- group:food_blackberries
        },
    }

end

function unilib.pkg.food_smoothie_blackberry.exec()

    unilib.register_craftitem("unilib:food_smoothie_blackberry", nil, mode, {
        -- Original to unilib, based on farming:smoothie_raspberry
        description = S("Blackberry Smoothie"),
        inventory_image = "unilib_food_smoothie_blackberry.png",
        groups = {drink = 1, food_blackberry_smoothie = 1, vessel = 1},

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_smoothie_blackberry", 2, "unilib:vessel_glass_empty"
        ),
    })
    unilib.register_craft({
        -- Original to unilib, based on farming:smoothie_raspberry
        output = "unilib:food_smoothie_blackberry",
        recipe = {
            {"unilib:snow_ordinary"},
            {"group:food_blackberries"},
            {"unilib:vessel_glass_empty"},
        },
    })

end
