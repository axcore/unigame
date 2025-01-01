---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_soup_asparagus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_soup_asparagus.init()

    return {
        description = "Asparagus soup",
        depends = {
            "crop_asparagus_white",
            "crop_chives",
            "food_milk_soy_red",
            "utensil_plate_ceramic",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.food_soup_asparagus.exec()

    unilib.register_node("unilib:food_soup_asparagus_raw", "cucina_vegana:asparagus_soup", mode, {
        -- From cucina_vegana:asparagus_soup
        description = S("Uncooked Asparagus Soup"),
        tiles = {"unilib_food_soup_asparagus_raw.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_soup = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_soup_asparagus_raw.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_soup_asparagus_raw.png",
    })
    unilib.register_craft({
        -- From cucina_vegana:asparagus_soup
        output = "unilib:food_soup_asparagus_raw",
        recipe = {
            {"unilib:crop_chives_harvest", "group:food_oil", "unilib:crop_asparagus_white_harvest"},
            {"", "unilib:food_milk_soy_red", ""},
            {"", "unilib:utensil_plate_ceramic", ""},
        },
        replacements = {
            {"group:food_milk", "unilib:vessel_bottle_glass_empty"},
            {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
        },
    })

    unilib.register_node(
        -- From cucina_vegana:asparagus_soup_cooked
        "unilib:food_soup_asparagus_cooked",
        "cucina_vegana:asparagus_soup_cooked",
        mode,
        {
            description = S("Cooked Asparagus Soup"),
            tiles = {"unilib_food_soup_asparagus_cooked.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1},
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_soup_asparagus_cooked.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_soup_asparagus_cooked.png",

            on_use = unilib.cuisine.eat_on_use(
                "unilib:food_soup_asparagus_cooked", 5, "unilib:utensil_plate_ceramic"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:asparagus_soup_cooked
        type = "cooking",
        output = "unilib:food_soup_asparagus_cooked",
        recipe = "unilib:food_soup_asparagus_raw",
        cooktime = 15,
    })

end
