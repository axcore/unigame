---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.food_chocolate_piece = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_chocolate_piece.init()

    return {
        description = "Pieces of chocolate",
        depends = "ingredient_paste_cocoa",
    }

end

function unilib.pkg.food_chocolate_piece.exec()

    unilib.register_craftitem("unilib:food_chocolate_piece", "cropocalypse:chocolate", mode, {
        -- From cropocalypse:chocolate
        description = S("Pieces of Chocolate"),
        inventory_image = "unilib_food_chocolate_piece.png",
        groups = {flammable = 1, food_chocolate = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_chocolate_piece", 4),
    })
    unilib.register_craft({
        -- From cropocalypse:chocolate
        type = "cooking",
        output = "unilib:food_chocolate_piece",
        recipe = "unilib:ingredient_paste_cocoa",
    })

end
