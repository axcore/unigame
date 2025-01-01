---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_soy_yellow_water = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_soy_yellow_water.init()

    return {
        description = "Jar of yellow soybeans in water",
        depends = {"crop_soy_yellow", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_soy_yellow_water.exec()

    unilib.register_craftitem(
        -- From cropocalypse:soybean_water
        "unilib:ingredient_soy_yellow_water",
        "cropocalypse:soybean_water",
        mode,
        {
            description = S("Jar of Yellow Soybeans in Water"),
            inventory_image = "unilib_ingredient_soy_yellow_water.png",
            groups = {flammable = 1, food_soybean_water = 1},

            on_use = unilib.cuisine.eat_on_use(
                "unilib:ingredient_soy_yellow_water", 1, "unilib:vessel_bottle_glass_empty"
            ),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:soybean_water
        type = "shapeless",
        output = "unilib:ingredient_soy_yellow_water",
        recipe = {
            "unilib:crop_soy_yellow_harvest",
            "unilib:crop_soy_yellow_harvest",
            "unilib:crop_soy_yellow_harvest",
            "unilib:vessel_bottle_glass_empty",
        },
    })

end
