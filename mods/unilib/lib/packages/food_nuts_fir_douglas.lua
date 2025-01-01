---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_nuts_fir_douglas = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_nuts_fir_douglas.init()

    return {
        description = "Douglas fir cone nuts",
        depends = "ingredient_cone_fir_douglas",
    }

end

function unilib.pkg.food_nuts_fir_douglas.exec()

    unilib.register_craftitem("unilib:food_nuts_fir_douglas", "moretrees:fir_nuts", mode, {
        -- From moretrees:fir_nuts
        description = S("Roasted Douglas Fir Cone Nuts"),
        inventory_image = "unilib_food_nuts_fir_douglas.png",
        -- N.B. No groups in original code
        groups = {food = 1, food_nut = 1, food_fir_douglas_nuts = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_nuts_fir_douglas", 1),
    })
    unilib.register_craft({
        -- From moretrees:fir_nuts
        type = "cooking",
        output = "unilib:food_nuts_fir_douglas 4",
        recipe = "unilib:ingredient_cone_fir_douglas",
    })

end

