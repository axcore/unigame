---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo (20241118 update)
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_butter_vegan = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_butter_vegan.init()

    return {
        description = "Vegan butter",
        depends = {
            "dye_basic",
            "ingredient_oil_sunflower",
            "utensil_bowl_mixing_glass",
            "vessel_bottle_glass_empty",
            "vessel_glass_empty",
        },
        suggested = {
            "food_milk_soy",                    -- group:food_soy_milk
            "ingredient_salt_normal",           -- group:food_salt
        },
    }

end

function unilib.pkg.ingredient_butter_vegan.exec()

    unilib.register_craftitem("unilib:ingredient_butter_vegan", "farming:butter_vegan", mode, {
        -- From farming:butter_vegan
        description = S("Vegan Butter"),
        inventory_image = "unilib_ingredient_butter_vegan.png",
        groups = {food_butter = 1},
    })
    unilib.register_craft({
        -- From farming:butter_vegan
        output = "unilib:ingredient_butter_vegan",
        -- N.B. "farming:soy_milk" in original code
        recipe = {
            {"group:food_soy_milk", "unilib:ingredient_oil_sunflower", "group:food_soy_milk"},
            {"group:food_salt", "unilib:dye_yellow", "unilib:utensil_bowl_mixing_glass"},
        },
        replacements = {
            {"group:food_soy_milk", "unilib:vessel_glass_empty 2"},
            {"unilib:ingredient_oil_sunflower", "unilib:vessel_bottle_glass_empty"},
            {"unilib:utensil_bowl_mixing_glass", "unilib:utensil_bowl_mixing_glass"},
        },
    })

end
