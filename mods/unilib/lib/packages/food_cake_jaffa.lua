---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_jaffa = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_jaffa.init()

    return {
        description = "Jaffa cake",
        depends = {"bucket_steel", "utensil_tray_baking"},
        optional = "bucket_wood",
        suggested = {
            "fruit_orange",                     -- group:food_orange
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_sugar_normal",          -- group:food_sugar
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_cake_jaffa.exec()

    unilib.register_craftitem("unilib:food_cake_jaffa", "farming:jaffa_cake", mode, {
        -- From farming:jaffa_cake
        description = S("Jaffa Cake"),
        inventory_image = "unilib_food_cake_jaffa.png",
        -- N.B. No groups in original code
        groups = {food_jaffa_cake = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cake_jaffa", 6),
    })
    unilib.register_craft({
        -- From farming:jaffa_cake
        output = "unilib:food_cake_jaffa",
        recipe = {
            {"unilib:utensil_tray_baking", "group:food_egg", "group:food_sugar"},
            {"group:food_flour", "group:food_cocoa", "group:food_orange"},
            {"group:food_milk", "", ""},
        },
        replacements = {
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
            -- (From animalia mod)
            {"animalia:bucket_milk", "unilib:bucket_steel_empty"},
            -- (From mobs_animal mod)
            {"mobs:bucket_milk", "unilib:bucket_steel_empty"},
            {"mobs:wooden_bucket_milk", "unilib:bucket_wood_empty"},
            -- (From petz/petz mod)
            {"petz:bucket_milk", "unilib:bucket_steel_empty"},
        },
    })
    unilib.register_external_ingredient("unilib:food_cake_jaffa", {
        "group:food_egg",                       -- Originally group:food_egg
        "group:food_milk",                      -- Originally group:food_milk
    })

end
