---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_potato_mashed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_potato_mashed.init()

    return {
        description = "Mashed potatoes",
        depends = {"crop_potato_sweet", "utensil_bowl_wooden"},
    }

end

function unilib.pkg.food_potato_mashed.exec()

    unilib.register_craftitem("unilib:food_potato_mashed", "cropocalypse:mashed_potatoes", mode, {
        -- From cropocalypse:mashed_potatoes
        description = S("Mashed Potatoes"),
        inventory_image = "unilib_food_potato_mashed.png",
        groups = {flammable = 1, food_mashed_potatoes = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_potato_mashed", 4),
    })
    unilib.register_craft({
        -- From cropocalypse:mashed_potatoes
        type = "shapeless",
        output = "unilib:food_potato_mashed",
        recipe = {
            "unilib:utensil_bowl_wooden",
            "unilib:crop_potato_sweet_harvest",
            "unilib:crop_potato_sweet_harvest",
            "unilib:crop_potato_sweet_harvest",
        },
    })

end
