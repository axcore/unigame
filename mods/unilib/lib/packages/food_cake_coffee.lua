---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_coffee = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_coffee.init()

    return {
        description = "Coffee cake",
        depends = "shared_pie",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_coffee",                   -- group:food_coffee
        },
    }

end

function unilib.pkg.food_cake_coffee.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:coff_0, etc. Creates unilib:food_cake_coffee_1, etc
        part_name = "food_cake_coffee",
        orig_part_name = "coff",

        replace_mode = mode,
        description = S("Coffee Cake"),
    })
    unilib.register_craft({
        -- From pie:coff_0
        output = "unilib:food_cake_coffee_1",
        recipe = {
            {"group:food_coffee", "group:food_milk", "group:food_coffee"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_wheat", "group:food_flour", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_cake_coffee_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
