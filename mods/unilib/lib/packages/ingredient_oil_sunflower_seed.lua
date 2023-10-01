---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_sunflower_seed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_sunflower_seed.init()

    return {
        description = "Bottle of sunflower seed oil",
        depends = {"food_seed_sunflower_dwarf", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_oil_sunflower_seed.exec()

    local c_seeds = "unilib:food_seed_sunflower_dwarf"

    unilib.register_node(
        -- From cucina_vegana:sunflower_seeds_oil
        "unilib:ingredient_oil_sunflower_seed",
        "cucina_vegana:sunflower_seeds_oil",
        mode,
        {
            description = S("Bottle of Sunflower Seed Oil"),
            tiles = {"unilib_ingredient_oil_sunflower_seed.png"},
            groups = {
                attached_node = 1, dig_immediate = 3, eatable = 1, food = 1, food_oil = 1,
                food_vegan = 1, vessel = 1,
            },
            sounds = unilib.sound_table.glass,

            drawtype = "plantlike",
            inventory_image = "unilib_ingredient_oil_sunflower_seed.png",
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25},
            },
            walkable = false,
            wield_image = "unilib_ingredient_oil_sunflower_seed.png",

            on_use = unilib.cuisine_eat_on_use(
                "unilib:ingredient_oil_sunflower_seed", 2, "unilib:vessel_bottle_glass_empty"
            ),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds_oil
        output = "unilib:ingredient_oil_sunflower_seed",
        recipe = {
            {c_seeds, c_seeds, c_seeds},
            {c_seeds, c_seeds, c_seeds},
            {"", "unilib:vessel_bottle_glass_empty", ""}
        },
    })
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds_oil
        type = "fuel",
        recipe = "unilib:ingredient_oil_sunflower_seed",
        replacements = {
            {"unilib:ingredient_oil_sunflower_seed", "unilib:vessel_bottle_glass_empty"},
        },
        burntime = 30,
    })
    if unilib.technic_extra_flag then

        technic.register_compressor_recipe({
            -- From cucina_vegana:sunflower_seeds_oil
            output = "unilib:ingredient_oil_sunflower_seed 6",
            input = {c_seeds},
        })

        technic.register_extractor_recipe({
            -- From cucina_vegana:sunflower_seeds_oil
            output = "unilib:ingredient_oil_sunflower_seed",
            input = {"unilib:food_seed_sunflower_dwarf 6"},
        })

    end

end
