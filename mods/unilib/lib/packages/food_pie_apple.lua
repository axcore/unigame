---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pie_apple = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pie_apple.init()

    return {
        description = "Apple pie",
        depends = "utensil_tray_baking",
        suggested = {
            "fruit_apple",                      -- group:food_apple
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_pie_apple.exec()

    unilib.register_craftitem("unilib:food_pie_apple", "farming:apple_pie", mode, {
        -- From farming:apple_pie
        description = S("Apple Pie"),
        inventory_image = "unilib_food_pie_apple.png",
        -- N.B. No groups in original code
        groups = {food_apple_pie = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_pie_apple", 6),
    })
    unilib.register_craft({
        -- From farming:apple_pie
        output = "unilib:food_pie_apple",
        recipe = {
            {"group:food_flour", "group:food_sugar", "group:food_apple"},
            {"", "unilib:utensil_tray_baking", ""}
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

end
