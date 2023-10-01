---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_fish_parsley_rosemary = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_fish_parsley_rosemary.init()

    return {
        description = "Fish on parsley and rosemary",
        depends = {
            "crop_parsley_curly",
            "crop_rosemary",
            "utensil_plate_ceramic",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "food_fish_imitation",              -- group:food_fish
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.food_fish_parsley_rosemary.exec()

    unilib.register_node(
        -- From cucina_vegana:fish_parsley_rosemary
        "unilib:food_fish_parsley_rosemary_raw",
        "cucina_vegana:fish_parsley_rosemary",
        mode,
        {
            description = S("Uncooked Fish on Parsley and Rosemary"),
            tiles = {"unilib_food_fish_parsley_rosemary_raw.png"},
            groups = {attached_node = 1, dig_immediate = 3},
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_fish_parsley_rosemary_raw.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_fish_parsley_rosemary_raw.png",
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:fish_parsley_rosemary
        output = "unilib:food_fish_parsley_rosemary_raw",
        recipe = {
            {"unilib:crop_parsley_curly_harvest", "group:food_oil", "unilib:crop_rosemary_harvest"},
            {"", "group:food_fish", ""},
            {"", "unilib:utensil_plate_ceramic", ""},
        },
        replacements = {
            {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
        },
    })

    unilib.register_node(
        -- From cucina_vegana:fish_parsley_rosemary_cooked
        "unilib:food_fish_parsley_rosemary_cooked",
        "cucina_vegana:fish_parsley_rosemary_cooked",
        mode,
        {
            description = S("Cooked Fish on Parsley and Rosemary"),
            tiles = {"unilib_food_fish_parsley_rosemary_cooked.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1},
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_fish_parsley_rosemary_cooked.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
            },
            walkable = false,
            wield_image = "unilib_food_fish_parsley_rosemary_cooked.png",

            on_use = unilib.cuisine_eat_on_use(
                "unilib:food_fish_parsley_rosemary_cooked", 6, "unilib:utensil_plate_ceramic"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:fish_parsley_rosemary_cooked
        type = "cooking",
        output = "unilib:food_fish_parsley_rosemary_cooked",
        recipe = "unilib:food_fish_parsley_rosemary_raw",
        cooktime = 18,
    })

end
