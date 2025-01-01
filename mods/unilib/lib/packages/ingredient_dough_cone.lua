---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    icecream
-- Code:    GPL-3.0
-- Media:   GPL-3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_dough_cone = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.icecream.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_dough_cone.init()

    return {
        description = "Ice cream cone dough",
        depends = "ingredient_flour_ordinary",
    }

end

function unilib.pkg.ingredient_dough_cone.exec()

    unilib.register_craftitem("unilib:ingredient_dough_cone", "icecream:dough", mode, {
        -- From icecream:dough
        description = S("Ice Cream Cone Dough"),
        inventory_image = "unilib_ingredient_dough_cone.png",

        on_use = unilib.cuisine.eat_on_use("unilib:ingredient_dough_cone", 1),
    })
    unilib.register_craft({
        -- From icecream:dough
        output = "unilib:ingredient_dough_cone",
        recipe = {
            {"", "", ""},
            {"unilib:ingredient_flour_ordinary", "", "unilib:ingredient_flour_ordinary"},
            {"", "group:food_egg", ""},
        },
    })
    unilib.register_external_ingredient("unilib:ingredient_dough_cone", {
        "group:food_egg",                       -- Originally group:food_egg
    })

    unilib.register_craftitem("unilib:ingredient_dough_cone_shaped", "icecream:notcone", mode, {
        -- From icecream:notcone
        description = S("Shaped Ice Cream Cone Dough"),
        inventory_image = "unilib_ingredient_dough_cone_shaped.png",

        on_use = unilib.cuisine.eat_on_use("unilib:ingredient_dough_cone_shaped", 1),
    })
    unilib.register_craft({
        -- From icecream:notcone
        output = "unilib:ingredient_dough_cone_shaped 5",
        recipe = {
            {"unilib:ingredient_dough_cone"},
        },
    })

end
