---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_tofu_red_chives_rosemary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_tofu_red_chives_rosemary.init()

    return {
        description = "Red tofu on chives and rosemary",
        depends = {"crop_chives", "crop_rosemary", "food_tofu_red", "utensil_plate_ceramic"},
    }

end

function unilib.pkg.food_tofu_red_chives_rosemary.exec()

    unilib.register_node(
        -- From cucina_vegana:tofu_chives_rosemary
        "unilib:food_tofu_red_chives_rosemary_raw",
        "cucina_vegana:tofu_chives_rosemary",
        mode,
        {
            description = S("Red Tofu on Chives and Rosemary"),
            tiles = {"unilib_food_tofu_red_chives_rosemary_raw.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1, food_vegan = 1},
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_tofu_red_chives_rosemary_raw.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_tofu_red_chives_rosemary_raw.png",

            on_use = unilib.cuisine_eat_on_use(
                "unilib:food_tofu_red_chives_rosemary_raw", 5, "unilib:utensil_plate_ceramic"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:tofu_chives_rosemary
        output = "unilib:food_tofu_red_chives_rosemary_raw",
        recipe = {
            {"unilib:crop_chives_harvest", "", "unilib:crop_rosemary_harvest"},
            {"", "unilib:food_tofu_red_raw", ""},
            {"", "unilib:utensil_plate_ceramic", ""},
        },
    })

    unilib.register_node(
        -- From cucina_vegana:tofu_chives_rosemary_cooked
        "unilib:food_tofu_red_chives_rosemary_cooked",
        "cucina_vegana:tofu_chives_rosemary_cooked",
        mode,
        {
            description = S("Cooked Red Tofu on Chives and Rosemary"),
            tiles = {"unilib_food_tofu_red_chives_rosemary_cooked.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1},
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_tofu_red_chives_rosemary_cooked.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_tofu_red_chives_rosemary_cooked.png",

            on_use = unilib.cuisine_eat_on_use(
                "unilib:food_tofu_red_chives_rosemary_cooked", 6, "unilib:utensil_plate_ceramic"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:tofu_chives_rosemary_cooked
        type = "cooking",
        output = "unilib:food_tofu_red_chives_rosemary_cooked",
        recipe = "unilib:food_tofu_red_chives_rosemary_raw",
        cooktime = 18,
    })

end
