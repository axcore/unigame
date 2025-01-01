---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pie_blueberry_simple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pie_blueberry_simple.init()

    return {
        description = "Simple blueberry pie",
        depends = "utensil_tray_baking",
        suggested = {
            "fruit_blueberry_ordinary",         -- group:food_blueberries
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_pie_blueberry_simple.exec()

    unilib.register_craftitem("unilib:food_pie_blueberry_simple", "farming:blueberry_pie", mode, {
        -- From farming:blueberry_pie
        description = S("Simple Blueberry Pie"),
        inventory_image = "unilib_food_pie_blueberry_simple.png",
        -- N.B. No groups in original code
        groups = {food_blueberry_pie = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pie_blueberry_simple", 6),
    })
    unilib.register_craft({
        -- From farming:blueberry_pie
        output = "unilib:food_pie_blueberry_simple",
        recipe = {
            {"group:food_flour", "group:food_sugar", "group:food_blueberries"},
            {"unilib:utensil_tray_baking", "", ""},
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

end
