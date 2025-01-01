---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_rice = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_rice.init()

    return {
        description = "Rice flour",
        depends = {"crop_rice_white", "utensil_mortar_pestle"},
    }

end

function unilib.pkg.ingredient_flour_rice.exec()

    local c_rice = "unilib:crop_rice_white_harvest"

    unilib.register_craftitem("unilib:ingredient_flour_rice", "farming:rice_flour", mode, {
        -- From farming:rice_flour
        description = S("Rice Flour"),
        inventory_image = "unilib_ingredient_flour_rice.png",
        -- N.B. food_flour group not in original code, but is added by cucina_vegana overrides
        groups = {flammable = 1, food_flour = 1, food_rice_flour = 1},
    })
    -- N.B. For unilib flours, mortar-and-pestle recipes are preferred, if available
    if unilib.global.pkg_executed_table["utensil_mortar_pestle"] == nil then

        unilib.register_craft({
            -- Original to unilib
            type = "shapeless",
            output = "unilib:ingredient_flour_rice",
            recipe = {c_rice, c_rice, c_rice, c_rice},
        })

    else

        unilib.register_craft({
            -- From farming:rice_flour
            output = "unilib:ingredient_flour_rice",
            recipe = {
                {c_rice, c_rice, c_rice},
                {c_rice, "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end

end
