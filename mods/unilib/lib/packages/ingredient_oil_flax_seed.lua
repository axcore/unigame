---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_flax_seed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_flax_seed.init()

    return {
        description = "Bottle of flaxseed oil",
        depends = "vessel_bottle_glass_empty",
        at_least_one = {"crop_flax_brown", "crop_flax_golden"},
    }

end

function unilib.pkg.ingredient_oil_flax_seed.exec()

    unilib.register_node("unilib:ingredient_oil_flax_seed", "cucina_vegana:flax_seed_oil", mode, {
        -- From cucina_vegana:flax_seed_oil
        description = S("Bottle of Flaxseed Oil"),
        tiles = {"unilib_ingredient_oil_flax_seed.png"},
        groups = {
            attached_node = 1, dig_immediate = 3, eatable = 1, food = 1, food_oil = 1,
            food_vegan = 1, vessel = 1,
        },
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = "unilib_ingredient_oil_flax_seed.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
        },
        walkable = false,
        wield_image = "unilib_ingredient_oil_flax_seed.png",

        on_use = unilib.cuisine.eat_on_use(
            "unilib:ingredient_oil_flax_seed", 2, "unilib:vessel_bottle_glass_empty"
        ),
    })
    unilib.register_craft({
        -- From cucina_vegana:flax_seed_oil
        output = "unilib:ingredient_oil_flax_seed",
        recipe = {
            {"group:seed_flax", "group:seed_flax", "group:seed_flax"},
            {"group:seed_flax", "group:seed_flax", "group:seed_flax"},
            {"", "unilib:vessel_bottle_glass_empty", ""},
        },
    })
    unilib.register_craft({
        -- From cucina_vegana:flax_seed_oil
        type = "fuel",
        recipe = "unilib:ingredient_oil_flax_seed",
        replacements = {
            {"unilib:ingredient_oil_flax_seed", "unilib:vessel_bottle_glass_empty"},
        },
        burntime = 30,
    })
    if unilib.setting.technic_extra_flag then

        technic.register_compressor_recipe({
            -- From cucina_vegana:flax_seed_oil
            output = "unilib:ingredient_oil_flax_seed",
            input = {"unilib:crop_flax_golden_seed 6"},
        })

        technic.register_extractor_recipe({
            -- From cucina_vegana:flax_seed_oil
            output = "unilib:ingredient_oil_flax_seed",
            input = {"unilib:crop_flax_golden_seed 6"},
        })

    end

end
