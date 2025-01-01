---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_vinegar_apple_cider = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_vinegar_apple_cider.init()

    return {
        description = "Apple cider vinegar",
        depends = {"food_sliced_apple", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_vinegar_apple_cider.exec()

    unilib.register_craftitem(
        -- From cropocalypse:apple_cider_vinegar
        "unilib:ingredient_vinegar_apple_cider",
        "cropocalypse:apple_cider_vinegar",
        mode,
        {
            description = S("Apple Cider Vinegar"),
            inventory_image = "unilib_ingredient_vinegar_apple_cider.png",
            groups = {flammable = 1, food_apple_cider_vinegar = 1},

            on_use = unilib.cuisine.eat_on_use(
                "unilib:ingredient_vinegar_apple_cider", 1, "unilib:vessel_bottle_glass_empty"
            ),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:apple_cider_vinegar
        type = "shapeless",
        output = "unilib:ingredient_vinegar_apple_cider",
        recipe = {
            "unilib:food_sliced_apple",
            "unilib:food_sliced_apple",
            "unilib:ingredient_sugar_beet",
            "unilib:vessel_bottle_glass_empty",
        },
    })

end
