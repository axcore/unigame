---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_butter_soy_yellow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_butter_soy_yellow.init()

    return {
        description = "Yellow soybean butter",
        depends = {
            "food_milk_soy_yellow",
            "ingredient_agar_kelp",
            "ingredient_vinegar_apple_cider",
            "utensil_bowl_wooden",
        },
    }

end

function unilib.pkg.ingredient_butter_soy_yellow.exec()

    unilib.register_craftitem(
        -- From cropocalypse:soy_butter
        "unilib:ingredient_butter_soy_yellow",
        "cropocalypse:soy_butter",
        mode,
        {
            description = S("Yellow Soybean Butter"),
            inventory_image = "unilib_ingredient_butter_soy_yellow.png",
            -- N.B. food_butter = 1 not in original code
            groups = {flammable = 1, food_butter = 1, food_soy_butter = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:ingredient_butter_soy_yellow", 4),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:soy_butter
        type = "shapeless",
        output = "cropocalypse:soy_butter",
        recipe = {
            "unilib:utensil_bowl_wooden",
            "unilib:food_milk_soy_yellow",
            "unilib:ingredient_vinegar_apple_cider",
            "unilib:ingredient_agar_kelp",
        },
    })

end
