---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cheese
-- Code:    LGPL 2.1
-- Media:   CC-BY-SA 3.0 UNPORTED / CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_butter_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.cheese.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_butter_normal.init()

    return {
        description = "Normal butter",
    }

end

function unilib.pkg.ingredient_butter_normal.exec()

    unilib.register_craftitem("unilib:ingredient_butter_normal", "cheese:butter", mode, {
        -- From cheese:butter
        description = S("Normal Butter"),
        inventory_image = "unilib_ingredient_butter_normal.png",
        groups = {food_butter = 1, milk_product = 1},
    })

end
