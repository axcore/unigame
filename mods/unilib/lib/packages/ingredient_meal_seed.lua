---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_meal_seed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_meal_seed.init()

    return {
        description = "Seed meal",
        notes = "Can be baked into a seed cake",
        at_least_one = {"fruit_hinau", "fruit_karaka", "fruit_tawa"},
    }

end

function unilib.pkg.ingredient_meal_seed.exec()

    unilib.register_craftitem("unilib:ingredient_meal_seed", "aotearoa:seed_meal", mode, {
        -- From aotearoa:seed_meal
        description = S("Seed Meal"),
        inventory_image = "unilib_ingredient_meal_seed.png",
    })
    if unilib.pkg_executed_table["fruit_hinau"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:seed_meal
            type = "shapeless",
            output = "unilib:ingredient_meal_seed",
            recipe = {
                "unilib:fruit_hinau",
                "unilib:fruit_hinau",
                "unilib:fruit_hinau",
                "unilib:fruit_hinau",
            },
        })

    end
    if unilib.pkg_executed_table["fruit_karaka"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:seed_meal
            type = "shapeless",
            output = "unilib:ingredient_meal_seed",
            recipe = {
                "unilib:fruit_karaka",
                "unilib:fruit_karaka",
                "unilib:fruit_karaka",
                "unilib:fruit_karaka",
            },
        })

    end
    if unilib.pkg_executed_table["fruit_tawa"] ~= nil then

        unilib.register_craft({
            -- From aotearoa:seed_meal
            type = "shapeless",
            output = "unilib:ingredient_meal_seed",
            recipe = {
                "unilib:fruit_tawa",
                "unilib:fruit_tawa",
                "unilib:fruit_tawa",
                "unilib:fruit_tawa",
            },
        })

    end

end
