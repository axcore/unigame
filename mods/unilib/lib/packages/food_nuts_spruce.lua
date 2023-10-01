---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_nuts_spruce = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_nuts_spruce.init()

    return {
        description = "Spruce cone nuts",
        depends = "ingredient_cone_spruce",
    }

end

function unilib.pkg.food_nuts_spruce.exec()

    unilib.register_craftitem("unilib:food_nuts_spruce", "moretrees:spruce_nuts", mode, {
        -- From moretrees:spruce_nuts
        description = S("Roasted Spruce Cone Nuts"),
        inventory_image = "unilib_food_nuts_spruce.png",
        -- N.B. No groups in original code
        groups = {food = 1, food_nut = 1, food_spruce_nuts = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_nuts_spruce", 1),
    })
    unilib.register_craft({
        -- From moretrees:spruce_nuts
        type = "cooking",
        output = "unilib:food_nuts_spruce 4",
        recipe = "unilib:ingredient_cone_spruce",
    })

end
