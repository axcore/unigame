---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_ciabatta = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_ciabatta.init()

    return {
        description = "Ciabatta dough",
        depends = {
            "crop_rosemary",
            "food_milk_soy_red",
            "ingredient_oil_sunflower_seed",
            "vessel_bottle_glass_empty",
            "vessel_glass_empty",
        },
        suggested = {
            "ingredient_flour_ordinary",        -- group:food_flour
        },
    }

end

function unilib.pkg.ingredient_dough_ciabatta.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:ciabatta_dough
        "unilib:ingredient_dough_ciabatta",
        "cucina_vegana:ciabatta_dough",
        mode,
        {
            description = S("Ciabatta Dough"),
            inventory_image = "unilib_ingredient_dough_ciabatta.png",
            groups = {bread_dough = 1, food = 1},
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:ciabatta_dough
        output = "unilib:ingredient_dough_ciabatta",
        recipe = {
            {"unilib:food_milk_soy_red", "unilib:ingredient_oil_sunflower_seed", ""},
            {"group:food_flour", "unilib:crop_rosemary_harvest", ""},
        },
        replacements = {
            {"unilib:food_milk_soy_red", "unilib:vessel_glass_empty"},
            {"unilib:ingredient_oil_sunflower_seed", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
