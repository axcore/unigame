---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_nuts_pine = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_nuts_pine.init()

    return {
        description = "Pine nuts",
    }

end

function unilib.pkg.food_nuts_pine.exec()

    unilib.register_craftitem("unilib:food_nuts_pine", "ethereal:pine_nuts", mode, {
        -- From ethereal:pine_nuts
        description = S("Pine Nuts"),
        inventory_image = "unilib_food_nuts_pine.png",
        groups = {flammable = 2, food_pine_nuts = 1},

        wield_image = "unilib_food_nuts_pine.png",

        on_use = unilib.cuisine.eat_on_use("unilib:food_nuts_pine", 1),
    })

end
