---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cream_cactus = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cream_cactus.init()

    return {
        description = "Cactus cream",
        notes = "An alternative source of cream, and therefore butter, in case other sources" ..
                " are not available. Produced in a cream centrifuge"
    }

end

function unilib.pkg.ingredient_cream_cactus.exec()

    unilib.register_craftitem("unilib:ingredient_cream_cactus", "cheese:cactus_cream", mode, {
        -- From cheese:cactus_cream
        description = S("Cactus Cream"),
        inventory_image = "unilib_ingredient_cream_cactus.png^[colorize:green:30",
        groups = {food_cream = 1, food_vegan = 1, vegan_alternative = 1},
    })

end
