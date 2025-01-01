---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_sunflower_seed = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_sunflower_seed.init()

    return {
        description = "Sunflower seed dough",
        depends = "food_seed_sunflower_dwarf",
        suggested = {
            "ingredient_flour_ordinary",        -- group:food_flour
        },
    }

end

function unilib.pkg.ingredient_dough_sunflower_seed.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:sunflower_seeds_dough
        "unilib:ingredient_dough_sunflower_seed",
        "cucina_vegana:sunflower_seeds_dough",
        mode,
        {
            description = S("Sunflower Seed Dough"),
            inventory_image = "unilib_ingredient_dough_sunflower_seed.png",
            groups = {bread_dough = 1, eatable = 1, food = 1, food_vegan = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:ingredient_dough_sunflower_seed", 2),
        }
    )
    -- N.B. In original code, one of the craft recipes is redundant, as ordinary flour already has
    --      group:food_flour
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds_dough
        output = "unilib:ingredient_dough_sunflower_seed",
        recipe = {
            {"", "unilib:food_seed_sunflower_dwarf", ""},
            {"group:food_flour", "group:food_flour", "group:food_flour"},
        },
    })

end
