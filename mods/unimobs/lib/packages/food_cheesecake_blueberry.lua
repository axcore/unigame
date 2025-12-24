---------------------------------------------------------------------------------------------------
-- unimobs mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    petz/petz
-- Code:    GPL v3.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheesecake_blueberry = {}

local S = unimobs.intllib
local mode = unilib.global.imported_mod_table.petz.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheesecake_blueberry.init()

    return {
        description = "Blueberry cheesecake",
        depends = {"crop_wheat", "fruit_blueberry_ordinary"},
        suggested = {
            "egg_chicken_normal",               -- group:food_egg
            "food_cheese_normal",               -- group:food_cheese
        },
    }

end

function unilib.pkg.food_cheesecake_blueberry.exec()

    unilib.register_craftitem(
        -- From petz:blueberry_cheese_cake
        "unilib:food_cheesecake_blueberry",
        "petz:blueberry_cheese_cake",
        mode,
        {
            description = S("Blueberry Cheesecake"),
            inventory_image = "unilib_food_cheesecake_blueberry.png",
            groups = {flammable = 2, food = 2, food_cheese = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_cheesecake_blueberry", 6),
        }
    )
    unilib.register_craft({
        -- From petz:blueberry_cheese_cake
        type = "shapeless",
        output = "unilib:food_cheesecake_blueberry",
        recipe = {
            "unilib:fruit_blueberry_ordinary",
            "unilib:crop_wheat_harvest",
            "group:food_cheese",
            "group:food_egg",
        },
    })

end
