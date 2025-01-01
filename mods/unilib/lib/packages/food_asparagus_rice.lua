---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_asparagus_rice = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_asparagus_rice.init()

    return {
        description = "Asparagus on rice",
        depends = {"crop_asparagus_white", "utensil_bowl_glass"},
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "ingredient_butter_normal",         -- group:food_butter
        },
    }

end

function unilib.pkg.food_asparagus_rice.exec()

    unilib.register_node("unilib:food_asparagus_rice_raw", "cucina_vegana:asparagus_rice", mode, {
        -- From cucina_vegana:asparagus_rice
        description = S("Uncooked Asparagus on Rice"),
        tiles = {"unilib_food_asparagus_rice_raw.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_vegan = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_asparagus_rice_raw.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_asparagus_rice_raw.png",
    })
    unilib.register_craft({
        -- From cucina_vegana:asparagus_rice
        output = "unilib:food_asparagus_rice_raw",
        recipe = {
            {"unilib:crop_asparagus_white_harvest", "group:food_rice", "group:food_butter"},
            {"", "unilib:utensil_bowl_glass", ""},
        },
        replacements = {
            {"unilib:utensil_bowl_glass", "unilib:utensil_bowl_glass"},
        },
    })

    unilib.register_node(
        -- From cucina_vegana:asparagus_rice_cooked
        "unilib:food_asparagus_rice_cooked",
        "cucina_vegana:asparagus_rice_cooked",
        mode,
        {
            description = S("Cooked Asparagus on Rice"),
            tiles = {"unilib_food_asparagus_rice_cooked.png"},
            groups = {attached_node = 1, dig_immediate = 3, eatable = 1},
            sounds = unilib.global.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_food_asparagus_rice_cooked.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_food_asparagus_rice_cooked.png",

            on_use = unilib.cuisine.eat_on_use(
                "unilib:food_asparagus_rice_cooked", 6, "unilib:utensil_plate_ceramic"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:asparagus_rice_cooked
        type = "cooking",
        output = "unilib:food_asparagus_rice_cooked",
        recipe = "unilib:food_asparagus_rice_raw",
        cooktime = 10,
    })

end
