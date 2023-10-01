---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pie_orange = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pie_orange.init()

    return {
        description = "Orange pie",
        depends = "shared_pie",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "food_milk_soy_red",                -- group:food_milk
            "fruit_orange",                     -- group:food_orange
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_pie_orange.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:orange_0, etc. Creates unilib:food_pie_orange_1, etc
        part_name = "food_pie_orange",
        orig_part_name = "orange",

        replace_mode = mode,
        description = S("Orange Pie"),
    })
    unilib.register_craft({
        -- From pie:orange_0
        output = "unilib:food_pie_orange_1",
        recipe = {
            {"group:food_orange", "group:food_milk", "group:food_orange"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_wheat", "group:food_flour", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_pie_orange_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end

