---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unilib
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pie_potato_sweet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.unilib.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pie_potato_sweet.init()

    return {
        description = "Sweet potato pie",
        depends = {"crop_potato_sweet", "utensil_tray_baking"},
        suggested = {
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_pie_potato_sweet.exec()

    unilib.register_craftitem("unilib:food_pie_potato_sweet", nil, mode, {
        -- Original to unilib
        description = S("Sweet Potato Pie Pie"),
        inventory_image = "unilib_food_pie_potato_sweet.png",
        groups = {food_sweet_potato_pie = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pie_potato_sweet", 6),
    })
    unilib.register_craft({
        -- Original to unilib
        output = "unilib:food_pie_potato_sweet",
        recipe = {
            {"group:food_flour", "group:food_sugar", "unilib:crop_potato_sweet_harvest"},
            {"", "unilib:utensil_tray_baking", ""},
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

end
