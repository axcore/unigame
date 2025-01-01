---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_vegana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_vegana.init()

    return {
        description = "Pizza vegana",
        depends = {
            "crop_asparagus_white",
            "crop_radicchio",
            "crop_rosemary",
            "ingredient_dough_pizza",
            "ingredient_sauce_hollandaise",
        },
    }

end

function unilib.pkg.food_pizza_vegana.exec()

    local c_asparagus = "unilib:crop_asparagus_white_harvest"
    local c_radicchio = "unilib:crop_radicchio_harvest"
    local c_rosemary = "unilib:crop_rosemary_harvest"

    unilib.register_node("unilib:food_pizza_vegana_raw", "cucina_vegana:pizza_vegana_raw", mode, {
        -- From cucina_vegana:pizza_vegana_raw
        description = S("Uncooked Pizza Vegana"),
        tiles = {"unilib_food_pizza_vegana_raw.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_vegan = 1},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_pizza_vegana_raw.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_pizza_vegana_raw.png",
    })
    unilib.register_craft({
        -- From cucina_vegana:pizza_vegana_raw
        output = "unilib:food_pizza_vegana_raw",
        recipe = {
            {"", "unilib:ingredient_sauce_hollandaise", ""},
            {c_asparagus, c_radicchio, c_rosemary},
            {"", "unilib:ingredient_dough_pizza", ""},
        },
        replacements = {
            {"unilib:ingredient_sauce_hollandaise", "unilib:vessel_bottle_glass_empty"},
        },
    })

    unilib.register_node("unilib:food_pizza_vegana_cooked", "cucina_vegana:pizza_vegana", mode, {
        -- From cucina_vegana:pizza_vegana
        description = S("Cooked Pizza Vegana"),
        tiles = {"unilib_food_pizza_vegana_cooked.png"},
        groups = {attached_node = 1, dig_immediate = 3, eatable = 1, food_vegan = 1},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_pizza_vegana_cooked.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_pizza_vegana_cooked.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_pizza_vegana_cooked", 6),
    })
    unilib.register_craft({
        -- From cucina_vegana:pizza_vegana
        type = "cooking",
        output = "unilib:food_pizza_vegana_cooked",
        recipe = "unilib:food_pizza_vegana_raw",
        cooktime = 18,
    })

end
