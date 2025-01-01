---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_asparagus_hollandaise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_asparagus_hollandaise.init()

    return {
        description = "Asparagus hollandaise",
        depends = {
            "crop_asparagus_white",
            "crop_parsley_curly",
            "ingredient_sauce_hollandaise",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "utensil_plate_ceramic",            -- group:food_plate
        },
    }

end

function unilib.pkg.food_asparagus_hollandaise.exec()

    unilib.register_node(
        -- From cucina_vegana:asparagus_hollandaise
        "unilib:food_asparagus_hollandaise_raw",
        "cucina_vegana:asparagus_hollandaise",
        mode,
        {
            description = S("Uncooked Asparagus Hollandaise"),
            tiles = {"unilib_food_asparagus_hollandaise_raw.png"},
            groups = {attached_node = 1, dig_immediate = 3},
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_asparagus_hollandaise_raw.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_asparagus_hollandaise_raw.png",
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:asparagus_hollandaise
        output = "unilib:food_asparagus_hollandaise_raw",
        recipe = {
            {
                "unilib:crop_asparagus_white_harvest",
                "unilib:ingredient_sauce_hollandaise",
                "unilib:crop_parsley_curly_harvest",
            },
            {
                "",
                "group:food_plate",
                "",
            },
        },
        replacements = {
            {"unilib:ingredient_sauce_hollandaise", "unilib:vessel_bottle_glass_empty"},
        },
    })

    unilib.register_node(
        -- From cucina_vegana:asparagus_hollandaise_cooked
        "unilib:food_asparagus_hollandaise_cooked",
        "cucina_vegana:asparagus_hollandaise_cooked",
        mode,
        {
            description = S("Cooked Asparagus Hollandaise"),
            tiles = {"unilib_food_asparagus_hollandaise_cooked.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1},
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_asparagus_hollandaise_cooked.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_asparagus_hollandaise_cooked.png",

            on_use = unilib.cuisine.eat_on_use(
                "unilib:food_asparagus_hollandaise_cooked", 5, "unilib:utensil_plate_ceramic"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:asparagus_hollandaise_cooked
        type = "cooking",
        output = "unilib:food_asparagus_hollandaise_cooked",
        recipe = "unilib:food_asparagus_hollandaise_raw",
        cooktime = 18,
    })

end
