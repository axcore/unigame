---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_cornstarch = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_cornstarch.init()

    return {
        description = "Cornstarch",
        depends = {
            "utensil_bowl_wooden",
            "utensil_mortar_pestle",
            "utensil_tray_baking",
        },
        suggested = {
            "food_corn_cob",                    -- group:food_corn_cooked
        },
    }

end

function unilib.pkg.ingredient_cornstarch.exec()

    local c_corn_cob = "group:food_corn_cooked"

    unilib.register_craftitem("unilib:ingredient_cornstarch", "farming:cornstarch", mode, {
        -- From farming:cornstarch
        description = S("Cornstarch"),
        inventory_image = "unilib_ingredient_cornstarch.png",
        -- N.B. In original code, "food_flammable" instead of "flammable"
        groups = {food_cornstarch = 1, flammable = 2, food_gelatin = 1},
    })
    unilib.register_craft({
        -- From farming:cornstarch
        output = "unilib:ingredient_cornstarch",
        recipe = {
            {"unilib:utensil_mortar_pestle", c_corn_cob, "unilib:utensil_tray_baking"},
            {"", "unilib:utensil_bowl_wooden", ""},
        },
        replacements = {
            {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            {"unilib:utensil_tray_baking", "unilib:utensil_tray_baking"},
        },
    })

end
