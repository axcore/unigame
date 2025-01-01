---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cream_coconut = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cream_coconut.init()

    return {
        description = "Coconut cream",
        notes = "Produced by a cream centrifuge",
    }

end

function unilib.pkg.ingredient_cream_coconut.exec()

    unilib.register_craftitem("unilib:ingredient_cream_coconut", "cheese:coconut_cream", mode, {
        -- From cheese:coconut_cream
        description = S("Coconut Cream"),
        inventory_image = "unilib_ingredient_cream_coconut.png",
        groups = {food_cream = 1, food_vegan = 1, vegan_alternative = 1},
    })

end
