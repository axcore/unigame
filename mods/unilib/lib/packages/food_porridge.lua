---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_porridge = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_porridge.init()

    return {
        description = "Porridge",
        depends = {"crop_oat", "vessel_glass_empty"},
        suggested = {
            "crop_oat",                         -- group:food_oats
            "food_milk_soy",                    -- group:food_milk_glass
            "utensil_bowl_wooden",              -- group:food_bowl
        },
    }

end

function unilib.pkg.food_porridge.exec()

    unilib.register_craftitem("unilib:food_porridge", "farming:porridge", mode, {
        -- From farming:porridge
        description = S("Porridge"),
        inventory_image = "unilib_food_porridge.png",
        -- N.B. No groups in original code
        groups = {food_porridge = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_porridge", 6, "unilib:utensil_bowl_wooden"),
    })
    unilib.register_craft({
        -- From farming:porridge
        output = "unilib:food_porridge",
        recipe = {
            {"group:food_oats", "group:food_oats", "group:food_oats"},
            {"group:food_oats", "group:food_bowl", "group:food_milk_glass"}
        },
        replacements = {
            {"group:food_milk_glass", "unilib:vessel_glass_empty"},
            {"unilib:food_milk_soy", "unilib:vessel_glass_empty"},
        },
    })
    unilib.register_external_ingredient("unilib:food_porridge", {
        "group:food_milk_glass",                -- Originally mobs:glass_milk
    })

end
