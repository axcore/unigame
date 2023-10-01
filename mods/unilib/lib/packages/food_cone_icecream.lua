---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cone_icecream = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cone_icecream.init()

    return {
        description = "Ice cream cone",
        depends = "ingredient_dough_cone",
    }

end

function unilib.pkg.food_cone_icecream.exec()

    unilib.register_craftitem("unilib:food_cone_icecream", "icecream:cone", mode, {
        -- From icecream:cone
        description = S("Ice Cream Cone"),
        inventory_image = "unilib_food_cone_icecream.png",

        on_use = unilib.cuisine_eat_on_use("unilib:food_cone_icecream", 4),
    })
    unilib.register_craft({
        -- From icecream:cone
        type = "cooking",
        output = "unilib:food_cone_icecream",
        recipe = "unilib:ingredient_dough_cone_shaped",
    })

end
