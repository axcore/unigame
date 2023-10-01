---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cucina_vegana
-- Code:    LGPL3.0
-- Media:   LGPL3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_sunflower_dwarf = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cucina_vegana.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_sunflower_dwarf.init()

    return {
        description = "Dwarf sunflower seed bread",
        depends = "ingredient_dough_sunflower_seed",
        optional = {
            "food_seed_sunflower_dwarf",
            "ingredient_flour_ordinary",
            "ingredient_flour_rice_brown",
            "ingredient_flour_sunflower_seed",
        },
    }

end

function unilib.pkg.food_bread_sunflower_dwarf.exec()

    unilib.register_craftitem(
        -- From cucina_vegana:sunflower_seeds_bread
        "unilib:food_bread_sunflower_dwarf",
        "cucina_vegana:sunflower_seeds_bread",
        mode,
        {
            description = S("Dwarf Sunflower Seed Bread"),
            inventory_image = "unilib_food_bread_sunflower_dwarf.png",
            groups = {eatable = 1, food = 1, food_bread = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_bread_sunflower_dwarf", 4),
        }
    )
    unilib.register_craft({
        -- From cucina_vegana:sunflower_seeds_bread
        type = "cooking",
        output = "unilib:food_bread_sunflower_dwarf",
        recipe = "unilib:ingredient_dough_sunflower_seed",
        cooktime = 15,
    })
    if unilib.technic_extra_flag and
            unilib.pkg_executed_table["food_seed_sunflower_dwarf"] ~= nil then

        if unilib.pkg_executed_table["ingredient_flour_ordinary"] ~= nil then

            technic.register_alloy_recipe({
                -- From cucina_vegana:sunflower_seeds_bread
                output = "unilib:food_bread_sunflower_dwarf",
                input = {"unilib:ingredient_flour_ordinary 3", "unilib:food_seed_sunflower_dwarf"},
                time = 0,
            })

        end

        if unilib.pkg_executed_table["ingredient_flour_sunflower_seed"] ~= nil then

            technic.register_alloy_recipe({
                -- From cucina_vegana:sunflower_seeds_bread
                output = "unilib:food_bread_sunflower_dwarf",
                input = {
                    "unilib:ingredient_flour_sunflower_seed 3",
                    "unilib:food_seed_sunflower_dwarf",
                },
                time = 0,
            })

        end

        if unilib.pkg_executed_table["ingredient_flour_rice_brown"] ~= nil then

            technic.register_alloy_recipe({
                -- From cucina_vegana:sunflower_seeds_bread
                output = "unilib:food_bread_sunflower_dwarf",
                input = {
                    "unilib:ingredient_flour_rice_brown 3",
                    "unilib:food_seed_sunflower_dwarf",
                },
                time = 0,
            })

        end

    end

end
