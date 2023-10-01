---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bibimbap = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bibimbap.init()

    return {
        description = "Korean Bibimbap",
        depends = {"utensil_bowl_wooden", "utensil_skillet_normal"},
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "mushroom_brown",                   -- group:food_mushroom
            "produce_cabbage_normal",           -- group:food_cabbage
            "produce_carrot_normal",            -- group:food_carrot
            "produce_chilli_normal",            -- group:food_chilli_pepper
        },
    }

end

function unilib.pkg.food_bibimbap.exec()

    unilib.register_craftitem("unilib:food_bibimbap", "farming:bibimbap", mode, {
        -- From farming:bibimbap
        description = S("Korean Bibimbap"),
        inventory_image = "unilib_food_bibimbap.png",
        -- N.B. No groups in original code
        groups = {food_bibimbap = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bibimbap", 8, "unilib:utensil_bowl_wooden"),
    })
    unilib.register_craft({
        -- From farming:bibimbap
        output = "unilib:food_bibimbap",
        recipe = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_bowl_wooden", "group:food_egg"},
            {"group:food_rice", "group:food_chicken_raw", "group:food_cabbage"},
            {"group:food_carrot", "group:food_chilli_pepper", ""}
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        }
    })
    unilib.register_external_ingredient("unilib:food_bibimbap", {
        "group:food_chicken_raw",               -- Originally group:food_chicken_raw
        "group:food_egg",                       -- Originally group:food_egg
    })
    unilib.register_craft({
        -- From farming:bibimbap
        output = "unilib:food_bibimbap",
        type = "shapeless",
        recipe = {
            "unilib:utensil_skillet_normal",
            "unilib:utensil_bowl_wooden",
            "group:food_mushroom",
            "group:food_rice",
            "group:food_cabbage",
            "group:food_carrot",
            "group:food_mushroom",
            "group:food_chilli_pepper"
        },
        replacements = {
            {"unilib:utensil_skillet_normal", "unilib:utensil_skillet_normal"},
        },
    })

end
