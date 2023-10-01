---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sugar_beet = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sugar_beet.init()

    return {
        description = "Beet sugar",
        depends = "crop_beet_common",
    }

end

function unilib.pkg.ingredient_sugar_beet.exec()

    local c_beet = "unilib:crop_beet_common_harvest"

    unilib.register_craftitem("unilib:ingredient_sugar_beet", "cropocalypse:sugar", mode, {
        -- From cropocalypse:sugar
        description = S("Beet Sugar"),
        inventory_image = "unilib_ingredient_sugar_beet.png",
        groups = {flammable = 1, food_sugar = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:ingredient_sugar_beet", 1),
    })
    unilib.register_craft({
        -- From cropocalypse:sugar
        type = "shapeless",
        output = "unilib:ingredient_sugar_beet 2",
        recipe = {c_beet, c_beet, c_beet},
    })

end
