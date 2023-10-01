---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    ethereal-ng
-- Code:    MIT
-- Media:   MIT/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_oil_olive = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.ethereal.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_oil_olive.init()

    return {
        description = "Olive oil",
        depends = {"fruit_olive", "utensil_juicer_normal", "vessel_bottle_glass_empty"},
    }

end

function unilib.pkg.ingredient_oil_olive.exec()

    unilib.register_craftitem("unilib:ingredient_oil_olive", "ethereal:olive_oil", mode, {
        -- From ethereal:olive_oil
        description = S("Olive Oil"),
        inventory_image = "unilib_ingredient_oil_olive.png",
        groups = {food_oil = 1, food_olive_oil = 1, vessel = 1},

        wield_image = "unilib_ingredient_oil_olive.png",
    })
    unilib.register_craft({
        -- From ethereal:olive_oil
        output = "unilib:ingredient_oil_olive",
        recipe = {
            {"unilib:fruit_olive", "unilib:fruit_olive", "unilib:fruit_olive"},
            {"unilib:fruit_olive", "unilib:fruit_olive", "unilib:fruit_olive"},
            {"unilib:utensil_juicer_normal", "unilib:vessel_bottle_glass_empty", ""}
        },
        replacements = {
            {"unilib:utensil_juicer_normal", "unilib:utensil_juicer_normal"},
        },
    })

end
