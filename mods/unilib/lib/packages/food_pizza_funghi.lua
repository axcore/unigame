---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pizza_funghi = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pizza_funghi.init()

    return {
        description = "Pizza funghi",
        depends = {
            "crop_rosemary",
            "food_meat_imitation",
            "ingredient_dough_pizza",
            "mushroom_brown",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.food_pizza_funghi.exec()

    unilib.register_node("unilib:food_pizza_funghi_raw", "cucina_vegana:pizza_funghi_raw", mode, {
        -- From cucina_vegana:pizza_funghi_raw
        description = S("Uncooked Pizza Funghi"),
        tiles = {"unilib_food_pizza_funghi_raw.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_vegan = 1},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_pizza_funghi_raw.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_pizza_funghi_raw.png",
    })
    unilib.register_craft({
        -- From cucina_vegana:pizza_funghi_raw
        output = "unilib:food_pizza_funghi_raw",
        recipe = {
            {"", "group:food_oil", "unilib:crop_rosemary_harvest"},
            {"unilib:mushroom_brown", "unilib:food_meat_imitation", "unilib:mushroom_brown"},
            {"", "unilib:ingredient_dough_pizza", ""}
        },
        replacements = {
            {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
        },
    })

    unilib.register_node("unilib:food_pizza_funghi_cooked", "cucina_vegana:pizza_funghi", mode, {
        -- From cucina_vegana:pizza_funghi
        description = S("Cooked Pizza Funghi"),
        tiles = {"unilib_food_pizza_funghi_cooked.png"},
        groups = {attached_node = 1, dig_immediate = 3, eatable = 1, food_vegan = 1},
        -- (no sounds)

        drawtype = "plantlike",
        inventory_image = "unilib_food_pizza_funghi_cooked.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
        },
        walkable = false,
        wield_image = "unilib_food_pizza_funghi_cooked.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_pizza_funghi_cooked", 6),
    })
    unilib.register_craft({
        -- From cucina_vegana:pizza_funghi
        type = "cooking",
        output = "unilib:food_pizza_funghi_cooked",
        recipe = "unilib:food_pizza_funghi_raw",
        cooktime = 18,
    })

end
