---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_peanut = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_peanut.init()

    return {
        description = "Bottle of peanut oil",
        depends = "vessel_bottle_glass_empty",
        suggested = {
            "crop_peanut",                      -- group:seed_peanut
        },
    }

end

function unilib.pkg.ingredient_oil_peanut.exec()

    unilib.register_node("unilib:ingredient_oil_peanut", "cucina_vegana:peanut_oil", mode, {
        -- From cucina_vegana:peanut_oil
        description = S("Bottle of Peanut Oil"),
        tiles = {"unilib_ingredient_oil_peanut.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, eatable = 1, food = 1, food_oil = 1,
            food_vegan = 1, vessel = 1,
        },
        sounds = unilib.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_oil_peanut.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_ingredient_oil_peanut.png",

        on_use = unilib.cuisine_eat_on_use(
            "unilib:ingredient_oil_peanut", 5, "unilib:vessel_bottle_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From cucina_vegana:peanut_oil
        output = "unilib:ingredient_oil_peanut",
        recipe = {
            {"group:seed_peanut", "group:seed_peanut", "group:seed_peanut"},
            {"group:seed_peanut", "group:seed_peanut", "group:seed_peanut"},
            {"", "unilib:vessel_bottle_glass_empty", ""},
        },
    })
    unilib.register_craft({
        -- From cucina_vegana:peanut_oil
        type = "fuel",
        recipe = "unilib:ingredient_oil_peanut",
        replacements = {
            {"unilib:ingredient_oil_peanut", "unilib:vessel_bottle_glass_empty"},
        },
        burntime = 35,
    })
    if unilib.technic_extra_flag then

        technic.register_compressor_recipe({
            -- From cucina_vegana:peanut_oil
            output = "unilib:ingredient_oil_peanut",
            input = {"unilib:crop_peanut_seed 6"},
        })

        technic.register_extractor_recipe({
            -- From cucina_vegana:peanut_oil
            output = "unilib:ingredient_oil_peanut",
            input = {"unilib:crop_peanut_seed 6"},
        })

    end

end
