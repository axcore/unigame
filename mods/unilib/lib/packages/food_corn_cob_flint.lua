---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_corn_cob_flint = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_corn_cob_flint.init()

    return {
        description = "Flint Corn on the cob",
        depends = "produce_corn_flint",
    }

end

function unilib.pkg.food_corn_cob_flint.exec()

    unilib.register_craftitem("unilib:food_corn_cob_flint", nil, mode, {
        -- Original to unilib
        description = S("Flint Corn on the Cob"),
        inventory_image = "unilib_food_corn_cob_flint.png",
        groups = {flammable = 2, food_corn_cooked = 1, food_corn_on_the_cob = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_corn_cob_flint", 6),
    })
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:food_corn_cob_flint",
        recipe = "unilib:produce_corn_flint_harvest",
        cooktime = 10,
    })

end
