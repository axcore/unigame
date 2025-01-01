---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_garlic_porcelain = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_garlic_porcelain.init()

    return {
        description = "Porcelain garlic bread",
        depends = {"crop_garlic_porcelain", "food_bread_ordinary", "ingredient_butter_soy_yellow"},
    }

end

function unilib.pkg.food_bread_garlic_porcelain.exec()

    unilib.register_craftitem(
        -- From cropocalypse:uncooked_garlic_bread
        "unilib:food_bread_garlic_porcelain_uncooked",
        "cropocalypse:uncooked_garlic_bread",
        mode,
        {
            description = S("Uncooked Porcelain Garlic Bread"),
            inventory_image = "unilib_food_bread_garlic_porcelain_uncooked.png",
            groups = {flammable = 1, food_uncooked_garlic_bread = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_bread_garlic_porcelain_uncooked", 3),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:uncooked_garlic_bread
        type = "shapeless",
        output = "cropocalypse:uncooked_garlic_bread",
        recipe = {
            "unilib:food_bread_ordinary",
            "unilib:ingredient_butter_soy_yellow",
            "unilib:crop_garlic_porcelain_harvest",
        },
    })

    unilib.register_craftitem(
        -- From cropocalypse:cooked_garlic_bread
        "unilib:food_bread_garlic_porcelain",
        "cropocalypse:cooked_garlic_bread",
        mode,
        {
            description = S("Porcelain Garlic Bread"),
            inventory_image = "unilib_food_bread_garlic_porcelain.png",
            groups = {food_cooked_garlic_bread = 1, flammable = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_bread_garlic_porcelain", 8),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:cooked_garlic_bread
        type = "cooking",
        output = "unilib:food_bread_garlic_porcelain",
        recipe = "unilib:food_bread_garlic_porcelain_uncooked",
    })

end
