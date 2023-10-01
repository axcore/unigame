---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_rye = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_rye.init()

    return {
        description = "Rye flour",
        depends = "crop_rye",
        optional = "utensil_mortar_pestle",
    }

end

function unilib.pkg.ingredient_flour_rye.exec()

    local c_rye = "unilib:crop_rye_harvest"

    unilib.register_craftitem("unilib:ingredient_flour_rye", "grains:rye_flour", mode, {
        -- From grains:rye_flour
        description = S("Rye Flour"),
        inventory_image = "unilib_ingredient_flour_rye.png",
        -- N.B. food_flour not in original code
        groups = {flammable = 1, food_flour = 1},
    })
    -- N.B. For unilib flours, mortar-and-pestle recipes are preferred, if available
    if unilib.pkg_executed_table["utensil_mortar_pestle"] == nil then

        unilib.register_craft({
            -- From grains:rye_flour
            type = "shapeless",
            output = "unilib:ingredient_flour_rye",
            recipe = {c_rye, c_rye, c_rye, c_rye}
        })

    else

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_flour_rye",
            recipe = {
                {c_rye, c_rye, c_rye},
                {c_rye, "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end

end
