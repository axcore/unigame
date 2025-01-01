---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_mochi = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_mochi.init()

    return {
        description = "Mochi",
        depends = {
            "utensil_mortar_pestle",
            "vessel_glass_empty",
            "vessel_glass_with_water",
        },
        suggested = {
            "crop_rice_white",                  -- group:food_rice
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_mochi.exec()

    unilib.register_craftitem("unilib:food_mochi", "farming:mochi", mode, {
        -- From farming:mochi
        description = S("Mochi"),
        inventory_image = "unilib_food_mochi.png",
        -- N.B. no food_rice in original code
        groups = {flammable = 2, food_mochi = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_mochi", 3),
    })
    unilib.register_craft({
        -- From farming:mochi
        output = "unilib:food_mochi",
        recipe = {
            {"group:food_rice", "group:food_sugar", "group:food_rice"},
            {"", "unilib:utensil_mortar_pestle", ""},
            {"", "unilib:vessel_glass_with_water", ""},
        },
        replacements = {
            {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            {"unilib:vessel_glass_with_water", "unilib:vessel_glass_empty"},
        },
    })

end
