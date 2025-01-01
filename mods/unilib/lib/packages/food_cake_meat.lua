---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_meat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_meat.init()

    return {
        description = "Meat cake",
        depends = "shared_pie",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "food_meat_imitation",              -- group:food_meat_raw
        },
    }

end

function unilib.pkg.food_cake_meat.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:meat_0, etc. Creates unilib:food_cake_meat_1, etc
        part_name = "food_cake_meat",
        orig_part_name = "meat",

        replace_mode = mode,
        description = S("Meat Cake"),
    })
    unilib.register_craft({
        -- From pie:meat_0
        output = "unilib:food_cake_meat_1",
        recipe = {
            {"group:food_meat_raw", "group:food_egg", "group:food_meat_raw"},
            {"group:food_wheat", "group:food_wheat", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_cake_meat_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
