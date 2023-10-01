---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cocoa_roasted = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cocoa_roasted.init()

    return {
        description = "Roasted cocoa",
        depends = "food_pulp_cocoa",
    }

end

function unilib.pkg.food_cocoa_roasted.exec()

    unilib.register_craftitem("unilib:food_cocoa_roasted", "cropocalypse:roasted_cocao", mode, {
        -- From cropocalypse:roasted_cocao
        description = S("Roasted Cocoa"),
        inventory_image = "unilib_food_cocoa_roasted.png",
        groups = {flammable = 1, food_roasted_cocoa = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cocoa_roasted", 2),
    })
    unilib.register_craft({
        -- From cropocalypse:roasted_cocao
        type = "cooking",
        output = "unilib:food_cocoa_roasted",
        recipe = "unilib:food_pulp_cocoa",
    })

end
