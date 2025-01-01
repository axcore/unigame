---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    pie
-- Code:    MIT
-- Media:   CC-BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pudding_bread = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.pie.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pudding_bread.init()

    return {
        description = "Bread pudding",
        depends = "shared_pie",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "food_bread_ordinary",              -- group:food_bread
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_pudding_bread.exec()

    unilib.pkg.shared_pie.register_baking({
        -- From pie:brpd_0, etc. Creates unilib:food_pudding_bread_1, etc
        part_name = "food_pudding_bread",
        orig_part_name = "brpd",

        replace_mode = mode,
        description = S("Bread Pudding"),
    })
    unilib.register_craft({
        -- From pie:brpd_0
        output = "unilib:food_pudding_bread_1",
        recipe = {
            {"group:food_bread", "group:food_milk", "group:food_bread"},
            {"group:food_sugar", "group:food_egg", "group:food_sugar"},
            {"group:food_wheat", "group:food_flour", "group:food_wheat"},
        },
        replacements = unilib.pkg.shared_pie.replace_table,
    })
    unilib.register_external_ingredient("unilib:food_pudding_bread_1", {
        "group:food_egg",                       -- Originally group:food_egg
    })

end
