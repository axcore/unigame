---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_rice_brown = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_rice_brown.init()

    return {
        description = "Bowl of brown rice",
        depends = {"crop_rice_brown", "utensil_plate_ceramic"},
        suggested = {
            "bucket_steel",                     -- group:potable_bucket
        },
    }

end

function unilib.pkg.food_rice_brown.exec()

    unilib.register_node("unilib:food_rice_brown_raw", "cucina_vegana:bowl_rice", mode, {
        -- From cucina_vegana:bowl_rice
        description = S("Bowl of Uncooked Brown Rice"),
        tiles = {"unilib_food_rice_brown_raw.png"},
        groups = {attached_node = 1, dig_immediate = 3, food_rice = 1, food_vegan = 1, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_rice_brown_raw.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_rice_brown_raw.png",
    })

    unilib.register_node("unilib:food_rice_brown_cooked", "cucina_vegana:bowl_rice_cooked", mode, {
        -- From cucina_vegana:bowl_rice_cooked
        description = S("Bowl of Cooked Brown Rice"),
        tiles = {"unilib_food_rice_brown_cooked.png"},
        groups = {attached_node = 1, dig_immediate = 3, eatable = 1, vessel = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_rice_brown_cooked.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_rice_brown_cooked.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_rice_brown_cooked", 4, "unilib:utensil_bowl_glass"
        ),
    })
    unilib.register_craft({
        -- From cucina_vegana:bowl_rice_cooked
        type = "cooking",
        output = "unilib:food_rice_brown_cooked",
        recipe = "unilib:food_rice_brown_raw",
        cooktime = 20,
    })

end

function unilib.pkg.food_rice_brown.post()

    unilib.register_craft({
        -- From cucina_vegana:bowl_rice
        output = "unilib:food_rice_brown_raw",
        recipe = {
            {"unilib:crop_rice_brown_harvest"},
            {"group:potable_bucket"},
            {"unilib:utensil_plate_ceramic"},
        },
        replacements = unilib.global.potable_bucket_list,
    })

end
