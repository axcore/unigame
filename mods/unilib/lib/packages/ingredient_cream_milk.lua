---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cream_milk = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cream_milk.init()

    return {
        description = "Milk cream",
        notes = "Produced by a cream centrifuge",
    }

end

function unilib.pkg.ingredient_cream_milk.exec()

    unilib.register_craftitem("unilib:ingredient_cream_milk", "cheese:milk_cream", mode, {
        -- From cheese:milk_cream
        description = S("Milk Cream"),
        inventory_image = "unilib_ingredient_cream_milk.png",
        groups = {food_cream = 1, milk_product = 1},
    })

end
