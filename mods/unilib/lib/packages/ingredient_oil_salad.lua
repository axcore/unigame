---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_salad = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_salad.init()

    return {
        description = "Salad oil",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "crop_radicchio",                   -- group:seed_lettuce
        },
    }

end

function unilib.pkg.ingredient_oil_salad.exec()

    unilib.register_node("unilib:ingredient_oil_salad", "cucina_vegana:lettuce_oil", mode, {
        -- From cucina_vegana:lettuce_oil
        description = S("Salad Oil"),
        tiles = {"unilib_ingredient_oil_salad.png"},
        groups = {attached_node = 1, dig_immediate = 3, eatable = 1, food_oil = 1, food_vegan = 1},
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_oil_salad.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_ingredient_oil_salad.png",

        on_use = unilib.cuisine_eat_on_use(
            "unilib:ingredient_oil_salad", 2, "unilib:vessel_bottle_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From cucina_vegana:lettuce_oil
        output = "unilib:ingredient_oil_salad",
        recipe = {
            {"group:seed_lettuce", "group:seed_lettuce", "group:seed_lettuce"},
            {"group:seed_lettuce", "group:seed_lettuce", "group:seed_lettuce"},
            {"", "unilib:vessel_bottle_glass_empty", ""}
        },
    })
    unilib.register_craft({
        -- From cucina_vegana:lettuce_oil
        type = "fuel",
        recipe = "unilib:ingredient_oil_salad",
        replacements = {
            {"unilib:ingredient_oil_salad", "unilib:vessel_bottle_glass_empty"},
        },
        burntime = 30,
    })
    if unilib.technic_extra_flag then

        technic.register_compressor_recipe({
            -- From cucina_vegana:lettuce_oil
            output = "unilib:ingredient_oil_salad",
            input = {"unilib:crop_radicchio_seed 6"},
        })

        technic.register_extractor_recipe({
            -- From cucina_vegana:lettuce_oil
            output = "unilib:ingredient_oil_salad",
            input = {"unilib:crop_radicchio_seed 6"},
        })

    end

end
