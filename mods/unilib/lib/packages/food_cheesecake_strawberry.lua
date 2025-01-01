---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cheesecake_strawberry = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cheesecake_strawberry.init()

    return {
        description = "Strawberry cheesecake",
        depends = "shared_pie",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_cream_milk",            -- group:food_cream
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_strawberry_normal",        -- group:food_strawberry
        },
    }

end

function unilib.pkg.food_cheesecake_strawberry.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:scsk_0, etc. Creates unilib:food_cheesecake_strawberry_1, etc
        part_name = "food_cheesecake_strawberry",
        orig_part_name = "scsk",

        replace_mode = mode,
        description = S("Strawberry Cheesecake"),
    })
    unilib.register_craft({
        -- From pie:scsk_0
        output = "unilib:food_cheesecake_strawberry_1",
        recipe = {
            {"group:food_strawberry", "group:food_milk", "group:food_strawberry"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_wheat", "group:food_flour", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_craft({
        -- Additional craft recipe from cheese/items.lua
        output = "unilib:food_cheesecake_strawberry_1",
        recipe = {
            {"group:food_strawberry", "group:food_cream", "group:food_strawberry"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_wheat", "group:food_flour", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_cheesecake_strawberry_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
