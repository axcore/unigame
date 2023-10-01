---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_smoothie_raspberry = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_smoothie_raspberry.init()

    return {
        description = "Raspberry smoothie",
        depends = {"snow_ordinary", "vessel_glass_empty"},
        suggested = {
            "produce_raspberry",                -- group:food_raspberries
        },
    }

end

function unilib.pkg.food_smoothie_raspberry.exec()

    unilib.register_craftitem(
        -- From farming:smoothie_raspberry
        "unilib:food_smoothie_raspberry",
        "farming:smoothie_raspberry",
        mode,
        {
            description = S("Raspberry Smoothie"),
            inventory_image = "unilib_food_smoothie_raspberry.png",
            -- N.B. no food_raspberry in original code
            groups = {drink = 1, food_raspberry_smoothie = 1, vessel = 1},

            on_use = unilib.cuisine_eat_on_use(
                "unilib:food_smoothie_raspberry", 2, "unilib:vessel_glass_empty"
            ),
        }
    )
    unilib.register_craft({
        -- From farming:smoothie_raspberry
        output = "unilib:food_smoothie_raspberry",
        recipe = {
            {"unilib:snow_ordinary"},
            {"group:food_raspberries"},
            {"unilib:vessel_glass_empty"},
        },
    })

end
