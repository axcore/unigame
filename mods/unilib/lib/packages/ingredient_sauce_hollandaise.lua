---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sauce_hollandaise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sauce_hollandaise.init()

    return {
        description = "Sauce hollandaise",
        depends = {
            "crop_parsley_curly",
            "crop_rosemary",
            "food_milk_soy_red",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "ingredient_butter_normal",         -- group:food_butter
        },
    }

end

function unilib.pkg.ingredient_sauce_hollandaise.exec()

    local c_parsley = "unilib:crop_parsley_curly_harvest"
    local c_rosemary = "unilib:crop_rosemary_harvest"

    unilib.register_node(
        -- From cucina_vegana:sauce_hollandaise
        "unilib:ingredient_sauce_hollandaise",
        "cucina_vegana:sauce_hollandaise",
        mode,
        {
            description = S("Sauce Hollandaise"),
            tiles = {"unilib_ingredient_sauce_hollandaise.png"},
            groups = {
                attached_node = 1, dig_immediate = 3, eatable = 1, food = 1, food_sauce = 1,
                food_vegan = 1, vessel = 1,
            },
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_ingredient_sauce_hollandaise.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_ingredient_sauce_hollandaise.png",

            on_use = unilib.cuisine.eat_on_use(
                "unilib:ingredient_sauce_hollandaise", 3, "unilib:vessel_bottle_glass_empty"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:sauce_hollandaise
        output = "unilib:ingredient_sauce_hollandaise",
        recipe = {
            {c_parsley, "group:food_butter", c_rosemary},
            {"", "unilib:food_milk_soy_red", ""},
            {"", "unilib:vessel_bottle_glass_empty", ""},
        },
        replacements = {
            {"unilib:food_milk_soy_red", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
