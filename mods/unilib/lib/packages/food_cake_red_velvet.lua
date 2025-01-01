---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_red_velvet = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_red_velvet.init()

    return {
        description = "Red velvet cake",
        depends = {"dye_basic", "shared_pie"},
        suggested = {
            "food_cheese_vegan",                -- group:food_cheese
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_cream_milk",            -- group:food_cream
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_cake_red_velvet.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:rvel_0, etc. Creates unilib:food_cake_red_velvet_1, etc
        part_name = "food_cake_red_velvet",
        orig_part_name = "rvel",

        replace_mode = mode,
        description = S("Red Velvet Cake"),
    })
    unilib.register_craft({
        -- From pie:rvel_0
        output = "unilib:food_cake_red_velvet_1",
        recipe = {
            {"group:food_cocoa", "group:food_milk", "unilib:dye_red"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_flour", "group:food_cheese", "group:food_flour"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_craft({
        -- Additional craft recipe from cheese/items.lua
        output = "unilib:food_cake_red_velvet_1",
        recipe = {
            {"group:food_cocoa", "group:food_milk", "unilib:dye_red"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_flour", "group:food_cream", "group:food_flour"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_cake_red_velvet_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
