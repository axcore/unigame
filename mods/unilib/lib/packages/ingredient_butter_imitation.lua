---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_butter_imitation = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_butter_imitation.init()

    return {
        description = "Imitation butter",
        depends = {"dye_basic", "food_milk_soy_red", "vessel_glass_empty"},
    }

end

function unilib.pkg.ingredient_butter_imitation.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:imitation_butter
        "unilib:ingredient_butter_imitation",
        "cucina_vegana:imitation_butter",
        mode,
        {
            description = S("Imitation Butter"),
            inventory_image = "unilib_ingredient_butter_imitation.png",
            groups = {eatable = 1, food = 1, food_butter = 1, food_vegan = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:ingredient_butter_imitation", 2),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:imitation_butter
        output = "unilib:ingredient_butter_imitation",
        recipe = {
            {"unilib:dye_yellow", "unilib:food_milk_soy_red", "unilib:food_milk_soy_red"},
        },
        -- N.B. Original code returned only one drinking glass
        replacements = {
            {"unilib:food_milk_soy_red", "unilib:vessel_glass_empty 2"},
        },
    })

end
