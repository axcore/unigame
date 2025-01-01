---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_barley = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_barley.init()

    return {
        description = "Barley flour",
        depends = "crop_barley",
        optional = "utensil_mortar_pestle",
    }

end

function unilib.pkg.ingredient_flour_barley.exec()

    local c_barley = "unilib:crop_barley_harvest"

    unilib.register_craftitem("unilib:ingredient_flour_barley", "grains:barley_flour", mode, {
        -- From grains:barley_flour
        description = S("Barley Flour"),
        inventory_image = "unilib_ingredient_flour_barley.png",
        -- N.B. food_flour not in original code
        groups = {flammable = 1, food_flour = 1},
    })
    -- N.B. For unilib flours, mortar-and-pestle recipes are preferred, if available
    if unilib.global.pkg_executed_table["utensil_mortar_pestle"] == nil then

        unilib.register_craft({
            -- From grains:barley_flour
            type = "shapeless",
            output = "unilib:ingredient_flour_barley",
            recipe = {c_barley, c_barley, c_barley, c_barley}
        })

    else

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_flour_barley",
            recipe = {
                {c_barley, c_barley, c_barley},
                {c_barley, "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end

end
