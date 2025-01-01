---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_nuts_cedar = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_nuts_cedar.init()

    return {
        description = "Cedar cone nuts",
        depends = "ingredient_cone_cedar",
    }

end

function unilib.pkg.food_nuts_cedar.exec()

    unilib.register_craftitem("unilib:food_nuts_cedar", "moretrees:cedar_nuts", mode, {
        -- From moretrees:cedar_nuts
        description = S("Roasted Cedar Cone Nuts"),
        inventory_image = "unilib_food_nuts_cedar.png",
        -- N.B. No groups in original code
        groups = {food = 1, food_nut = 1, food_cedar_nuts = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_nuts_cedar", 1),
    })
    unilib.register_craft({
        -- From moretrees:cedar_nuts
        type = "cooking",
        output = "unilib:food_nuts_cedar 4",
        recipe = "unilib:ingredient_cone_cedar",
    })

end
