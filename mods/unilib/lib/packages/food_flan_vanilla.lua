---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_flan_vanilla = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_flan_vanilla.init()

    return {
        description = "Vanilla flan",
        depends = {
            "bucket_steel",
            "ingredient_caramel",
            "ingredient_extract_vanilla",
            "vessel_bottle_glass_empty",
        },
        optional = "bucket_wood",
        suggested = {
            "food_milk_soy_red",                -- group:food_milk
            "ingredient_sugar_normal",          -- group:food_sugar

        },
    }

end

function unilib.pkg.food_flan_vanilla.exec()

    unilib.register_craftitem("unilib:food_flan_vanilla", "farming:flan", mode, {
        -- From farming:flan
        description = S("Vanilla Flan"),
        inventory_image = "unilib_food_flan_vanilla.png",
        -- N.B. No groups in original code
        groups = {food_vanilla_flan = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_flan_vanilla", 6),
    })
    unilib.register_craft({
        -- From farming:flan
        output = "unilib:food_flan_vanilla",
        recipe = {
            {"group:food_sugar", "group:food_milk", "unilib:ingredient_caramel"},
            {"group:food_egg", "group:food_egg", "unilib:ingredient_extract_vanilla"},
        },
        replacements = {
            {"unilib:ingredient_extract_vanilla", "unilib:vessel_bottle_glass_empty"},
            -- (From animalia mod)
            {"animalia:bucket_milk", "unilib:bucket_steel_empty"},
            -- (From mobs_animal mod)
            {"mobs:bucket_milk", "unilib:bucket_steel_empty"},
            {"mobs:wooden_bucket_milk", "unilib:bucket_wood_empty"},
            -- (From petz/petz mod)
            {"petz:bucket_milk", "unilib:bucket_steel_empty"},
        },
    })
    unilib.register_external_ingredient("unilib:food_flan_vanilla", {
        "group:food_egg",                       -- Originally group:food_egg
        "group:food_milk",                      -- Originally group:food_milk
    })

end
