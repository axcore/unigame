---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_salad_green = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_salad_green.init()

    return {
        description = "Green salad",
        depends = {
            "crop_chives",
            "crop_parsley_curly",
            "crop_radicchio",
            "utensil_bowl_glass",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.food_salad_green.exec()

    local c_chives = "unilib:crop_chives_harvest"
    local c_parsley = "unilib:crop_parsley_curly_harvest"
    local c_radicchio = "unilib:crop_radicchio_harvest"

    unilib.register_node("unilib:food_salad_green", "cucina_vegana:salad_bowl", mode, {
        -- From cucina_vegana:salad_bowl
        description = S("Green Salad"),
        tiles = {"unilib_food_salad_green.png"},
        groups = {attached_node = 1, dig_immediate = 3},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_salad_green.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_salad_green.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_salad_green", 4, "unilib:utensil_bowl_glass"
        ),
    })
    unilib.register_craft({
        -- From cucina_vegana:salad_bowl
        output = "unilib:food_salad_green",
        recipe = {
            {c_parsley, c_radicchio, c_chives},
            {"", "group:food_oil", ""},
            {"", "unilib:utensil_bowl_glass", ""},
        },
        replacements = {
            {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
