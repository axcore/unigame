---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    cropocalypse
-- Code:    MIT
-- Media:   MIT
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_paste_cocoa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.cropocalypse.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_paste_cocoa.init()

    return {
        description = "Cocoa paste",
        depends = {"food_cocoa_roasted", "ingredient_sugar_beet"},
    }

end

function unilib.pkg.ingredient_paste_cocoa.exec()

    local c_sugar = "unilib:ingredient_sugar_beet"

    unilib.register_craftitem("unilib:ingredient_paste_cocoa", "cropocalypse:cocao_paste", mode, {
        -- From cropocalypse:cocao_paste
        description = S("Cocoa Paste"),
        inventory_image = "unilib_ingredient_paste_cocoa.png",
        groups = {flammable = 1, food_cocoa_paste = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:ingredient_paste_cocoa", 2),
    })
    unilib.register_craft({
        -- From cropocalypse:cocao_paste
        type = "shapeless",
        output = "unilib:ingredient_paste_cocoa",
        recipe = {"unilib:food_cocoa_roasted", c_sugar, c_sugar},
    })

end
