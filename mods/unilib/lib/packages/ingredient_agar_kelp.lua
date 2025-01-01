---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_agar_kelp = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_agar_kelp.init()

    return {
        description = "Kelp agar",
        depends = "ingredient_kelp_saltwater",
    }

end

function unilib.pkg.ingredient_agar_kelp.exec()

    unilib.register_craftitem("unilib:ingredient_agar_kelp", "cropocalypse:kelp_agar", mode, {
        -- From cropocalypse:kelp_agar
        description = S("Kelp Agar"),
        inventory_image = "unilib_ingredient_agar_kelp.png",
        groups = {flammable = 1, food_kelp_agar = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:ingredient_agar_kelp", 1),
    })
    unilib.register_craft({
        -- From cropocalypse:kelp_agar
        type = "cooking",
        output = "unilib:ingredient_agar_kelp",
        recipe = "unilib:ingredient_kelp_saltwater",
    })

end
