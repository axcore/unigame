---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_oat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_oat.init()

    return {
        description = "Oat flour",
        depends = "crop_oat",
        optional = "utensil_mortar_pestle",
    }

end

function unilib.pkg.ingredient_flour_oat.exec()

    local c_oat = "unilib:crop_oat_harvest"

    unilib.register_craftitem("unilib:ingredient_flour_oat", "grains:oat_flour", mode, {
        -- From grains:oat_flour
        description = S("Oat Flour"),
        inventory_image = "unilib_ingredient_flour_oat.png",
        -- N.B. food_flour not in original code
        groups = {flammable = 1, food_flour = 1},
    })
    -- N.B. For unilib flours, mortar-and-pestle recipes are preferred, if available
    if unilib.global.pkg_executed_table["utensil_mortar_pestle"] == nil then

        unilib.register_craft({
            -- From grains:oat_flour
            type = "shapeless",
            output = "unilib:ingredient_flour_oat",
            recipe = {c_oat, c_oat, c_oat, c_oat}
        })

    else

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_flour_oat",
            recipe = {
                {c_oat, c_oat, c_oat},
                {c_oat, "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end

end
