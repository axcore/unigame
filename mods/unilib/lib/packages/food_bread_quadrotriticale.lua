---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_quadrotriticale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_quadrotriticale.init()

    return {
        description = "Quadrotriticale bread",
        depends = "ingredient_flour_quadrotriticale",
    }

end

function unilib.pkg.food_bread_quadrotriticale.exec()

    -- N.B. 20% boost to health (compared to wheat/rye bread), but 33% longer cooking time
    unilib.register_craftitem(
        -- Code original to unilib, textures from barley in the "grains" mod
        "unilib:food_bread_quadrotriticale",
        "grains:quadrotriticale_bread",
        mode,
        {
            description = S("Quadrotriticale Bread"),
            inventory_image = "unilib_food_bread_quadrotriticale.png",
            groups = {flammable = 2, food_bread = 1},

            on_use = unilib.cuisine_eat_on_use("unilib:food_bread_quadrotriticale", 6),
        }
    )
    unilib.register_craft({
        -- Original to unilib
        type = "cooking",
        output = "unilib:food_bread_quadrotriticale",
        recipe = "unilib:ingredient_flour_quadrotriticale",
        cooktime = 20,
    })
    unilib.register_craft({
        -- Original to unilib
        type = "fuel",
        recipe = "unilib:food_bread_quadrotriticale",
        burntime = 2,
    })

end
