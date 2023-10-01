---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_edamame = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_edamame.init()

    return {
        description = "Edamame",
        depends = {"crop_peanut", "crop_rosemary", "utensil_plate_ceramic"},
        suggested = {
            "crop_soy_red",                     -- group:seed_soy
        },
    }

end

function unilib.pkg.food_edamame.exec()

    unilib.register_node("unilib:food_edamame_raw", "cucina_vegana:edamame", mode, {
        -- From cucina_vegana:edamame
        description = S("Uncooked Edamame"),
        tiles = {"unilib_food_edamame_raw.png"},
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_edamame_raw.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_edamame_raw.png",
    })
    unilib.register_craft({
        -- From cucina_vegana:edamame
        output = "unilib:food_edamame_raw",
        recipe = {
            {"unilib:crop_rosemary_harvest", "group:seed_soy", "unilib:crop_peanut_harvest"},
            {"group:seed_soy", "group:seed_soy", "group:seed_soy"},
            {"", "unilib:utensil_plate_ceramic", ""},
        },
    })

    unilib.register_node("unilib:food_edamame_cooked", "cucina_vegana:edamame_cooked", mode, {
        -- From cucina_vegana:edamame_cooked
        description = S("Cooked Edamame"),
        tiles = {"unilib_food_edamame_cooked.png"},
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_edamame_cooked.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_edamame_cooked.png",

        on_use = unilib.cuisine_eat_on_use(
            "unilib:food_edamame_cooked", 4, "unilib:utensil_plate_ceramic"
        ),
    })
    unilib.register_craft({
        -- From cucina_vegana:edamame_cooked
        type = "cooking",
        output = "unilib:food_edamame_cooked",
        recipe = "unilib:food_edamame_raw",
        cooktime = 7,
    })

end
