---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_mushroom_surprise = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_mushroom_surprise.init()

    return {
        description = "Mushroom surprise",
        depends = {
            "crop_mushroom_button",
            "crop_mushroom_morel_common",
            "crop_mushroom_oyster",
            "crop_mushroom_shiitake",
            "utensil_bowl_wooden",
        },
    }

end

function unilib.pkg.food_mushroom_surprise.exec()

    unilib.register_craftitem(
        -- From cropocalypse:mushroom_surprise
        "unilib:food_mushroom_surprise",
        "cropocalypse:mushroom_surprise",
        mode,
        {
            description = S("Mushroom Surprise"),
            inventory_image = "unilib_food_mushroom_surprise.png",
            groups = {flammable = 1, food_mushroom_surprise = 1},

            on_use = unilib.cuisine.eat_on_use("unilib:food_mushroom_surprise", 6),
        }
    )
    unilib.register_craft({
        -- From cropocalypse:mushroom_surprise
        type = "shapeless",
        output = "unilib:food_mushroom_surprise",
        recipe = {
            "unilib:utensil_bowl_wooden",
            "unilib:crop_mushroom_morel_common_harvest",
            "unilib:crop_mushroom_oyster_harvest",
            "unilib:crop_mushroom_shiitake_harvest",
            "unilib:crop_mushroom_button_harvest",
        },
    })

end
