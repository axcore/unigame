---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pie_rhubarb = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pie_rhubarb.init()

    return {
        description = "Rhubarb pie",
        depends = "utensil_tray_baking",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_rhubarb",                  -- group:food_rhubarb
        },
    }

end

function unilib.pkg.food_pie_rhubarb.exec()

    unilib.register_craftitem("unilib:food_pie_rhubarb", "farming:rhubarb_pie", mode, {
        -- From farming:rhubarb_pie
        description = S("Rhubarb Pie"),
        inventory_image = "unilib_food_pie_rhubarb.png",
        -- N.B. No groups in original code
        groups = {food_rhubarb_pie = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pie_rhubarb", 6),
    })
    unilib.register_craft({
        -- From farming:rhubarb_pie
        output = "unilib:food_pie_rhubarb",
        recipe = {
            {"unilib:utensil_tray_baking", "group:food_sugar", ""},
            {"group:food_rhubarb", "group:food_rhubarb", "group:food_rhubarb"},
            {"group:food_wheat", "group:food_wheat", "group:food_wheat"},
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

end
