---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_salad_hollandaise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_salad_hollandaise.init()

    return {
        description = "Salad hollandaise",
        depends = {"ingredient_sauce_hollandaise", "vessel_bottle_glass_empty"},
        optional = {
            "crop_chives",
            "crop_parsley_curly",
            "crop_radicchio",
            "food_salad_green",
            "utensil_bowl_glass",
        },
        suggested = {
            "ingredient_oil_sunflower",         -- group:food_oil
        },
    }

end

function unilib.pkg.food_salad_hollandaise.exec()

    unilib.register_node("unilib:food_salad_hollandaise", "cucina_vegana:salad_hollandaise", mode, {
        -- From cucina_vegana:salad_hollandaise
        description = S("Salad Hollandaise"),
        tiles = {"unilib_food_salad_hollandaise.png"},
        groups = {attached_node = 1, dig_immediate = 3, eatable = 1, food_vegan = 1},
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_food_salad_hollandaise.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_food_salad_hollandaise.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:food_salad_hollandaise", 5, "unilib:utensil_bowl_glass"
        ),
    })
    if unilib.global.pkg_executed_table["food_salad_green"] ~= nil and
             unilib.global.pkg_executed_table["utensil_bowl_glass"] ~= nil then

        unilib.register_craft({
            -- From cucina_vegana:salad_hollandaise
            output = "unilib:food_salad_hollandaise",
            recipe = {
                {"unilib:ingredient_sauce_hollandaise", "unilib:food_salad_green", ""},
            },
            replacements = {
                {"unilib:ingredient_sauce_hollandaise", "unilib:vessel_bottle_glass_empty"},
            },
        })

    end

    if unilib.global.pkg_executed_table["crop_chives"] ~= nil and
             unilib.global.pkg_executed_table["crop_parsley_curly"] ~= nil and
             unilib.global.pkg_executed_table["crop_radicchio"] ~= nil then

        local c_chives = "unilib:crop_chives_harvest"
        local c_parsley = "unilib:crop_parsley_curly_harvest"
        local c_radicchio = "unilib:crop_radicchio_harvest"

        unilib.register_craft({
            -- From cucina_vegana:salad_hollandaise
            output = "unilib:food_salad_hollandaise",
            recipe = {
                {c_parsley, c_radicchio, c_chives},
                {"unilib:ingredient_sauce_hollandaise", "group:food_oil", ""},
                {"", "unilib:utensil_bowl_glass", ""},
            },
            replacements = {
                {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
                {"unilib:ingredient_sauce_hollandaise", "unilib:vessel_bottle_glass_empty"},
            },
        })

    end

end
