---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pudding_chocolate = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pudding_chocolate.init()

    return {
        description = "Chocolate pudding",
        depends = "shared_pie",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_pudding_chocolate.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:choc_0, etc. Creates unilib:food_pudding_chocolate_1, etc
        part_name = "food_pudding_chocolate",
        orig_part_name = "choc",

        replace_mode = mode,
        description = S("Chocolate Pudding"),
    })
    unilib.register_craft({
        -- From pie:choc_0, etc
        output = "unilib:food_pudding_chocolate_1",
        recipe = {
            {"group:food_cocoa", "group:food_milk", "group:food_cocoa"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_wheat", "group:food_flour", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_pudding_chocolate_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
