---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    better_farming
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_marshmallow = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.better_farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_marshmallow.init()

    return {
        description = "Marshmallow",
        depends = {
            "crop_strawberry_gariguette",
            "ingredient_sugar_cane",
            "vessel_bottle_glass_empty",
            "vessel_bottle_glass_with_water",
        },
    }

end

function unilib.pkg.food_marshmallow.exec()

    unilib.register_craftitem("unilib:food_marshmallow", "better_farming:marshmallow", mode, {
        -- From better_farming:marshmallow
        description = S("Marshmallow"),
        inventory_image = "unilib_food_marshmallow.png",
        groups = {flammable = 2, food_marshmallow = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_marshmallow", 2),
    })
    unilib.register_craft({
        -- From better_farming:marshmallow
        output = "unilib:food_marshmallow",
        recipe = {
            {"unilib:ingredient_sugar_cane", "unilib:vessel_bottle_glass_with_water"},
            {"unilib:ingredient_sugar_cane", "unilib:ingredient_sugar_cane"},
            {"unilib:ingredient_sugar_cane", "unilib:crop_strawberry_gariguette_harvest"},
        },
        -- N.B. No replacements in original code
        replacements = {
            {"unilib:vessel_bottle_glass_with_water", "unilib:vessel_bottle_glass_empty"},
        },
    })

end
