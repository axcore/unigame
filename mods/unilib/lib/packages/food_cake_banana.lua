---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_banana = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_banana.init()

    return {
        description = "Banana cake",
        depends = "shared_pie",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "food_milk_soy_red",                -- group:food_milk
            "fruit_banana",                     -- group:food_banana
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_cake_banana.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:bana_0, etc. Creates unilib:food_cake_banana_1, etc
        part_name = "food_cake_banana",
        orig_part_name = "bana",

        replace_mode = mode,
        description = S("Banana Cake"),
    })
    unilib.register_craft({
        -- From pie:bana_0
        output = "unilib:food_cake_banana_1",
        recipe = {
            {"group:food_banana", "group:food_milk", "group:food_banana"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_wheat", "group:food_flour", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_cake_banana_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
