---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pasta = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pasta.init()

    return {
        description = "Pasta",
        depends = {
            "utensil_bowl_wooden",
            "vessel_bottle_glass_empty",
        },
        suggested = {
            "ingredient_butter_normal",         -- group:food_butter
            "ingredient_flour_ordinary",        -- group:food_flour
            "ingredient_oil_hemp",              -- group:food_oil

        },
    }

end

function unilib.pkg.food_pasta.exec()

    unilib.register_craftitem("unilib:food_pasta", "farming:pasta", mode, {
        -- From farming:pasta
        description = S("Pasta"),
        inventory_image = "unilib_food_pasta.png",
        groups = {food_pasta = 1},

        -- N.B. No .on_use() in original code. Same satiation value as spaghetti
        on_use = unilib.cuisine_eat_on_use("unilib:food_pasta", 8),
    })
    unilib.register_craft({
        -- From farming:pasta
        output = "unilib:food_pasta",
        recipe = {
            {"group:food_flour", "group:food_butter", "unilib:utensil_bowl_wooden"},
        },
        replacements = {
            {"unilib:utensil_bowl_wooden", "unilib:utensil_bowl_wooden"},
        },
    })
    unilib.register_craft({
        -- From farming:pasta
        output = "unilib:food_pasta",
        recipe = {
            {"group:food_flour", "group:food_oil", "unilib:utensil_bowl_wooden"},
        },
        replacements = {
            {"unilib:utensil_bowl_wooden", "unilib:utensil_bowl_wooden"},
            {"group:food_oil", "unilib:vessel_bottle_glass_empty"},
        }
    })

end
