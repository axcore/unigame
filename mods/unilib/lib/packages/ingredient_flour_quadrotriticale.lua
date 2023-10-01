---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    grains
-- Code:    MIT
-- Media:   CC BY 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_quadrotriticale = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.grains.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_quadrotriticale.init()

    return {
        description = "Quadrotriticale flour",
        depends = "crop_quadrotriticale",
        optional = "utensil_mortar_pestle",
    }

end

function unilib.pkg.ingredient_flour_quadrotriticale.exec()

    local c_quadrotriticale = "unilib:crop_quadrotriticale_harvest"

    unilib.register_craftitem(
        -- Code original to unilib, textures from barley in the "grains" mod
        "unilib:ingredient_flour_quadrotriticale",
        "grains:quadrotriticale_flour",
        mode,
        {
            description = S("Quadrotriticale Flour"),
            inventory_image = "unilib_ingredient_flour_quadrotriticale.png",
            groups = {flammable = 1, food_flour = 1},
        }
    )
    -- N.B. For unilib flours, mortar-and-pestle recipes are preferred, if available
    if unilib.pkg_executed_table["utensil_mortar_pestle"] == nil then

        unilib.register_craft({
            -- Original to unilib
            type = "shapeless",
            output = "unilib:ingredient_flour_quadrotriticale",
            recipe = {c_quadrotriticale, c_quadrotriticale, c_quadrotriticale, c_quadrotriticale},
        })

    else

        unilib.register_craft({
            -- Original to unilib
            output = "unilib:ingredient_flour_quadrotriticale",
            recipe = {
                {c_quadrotriticale, c_quadrotriticale, c_quadrotriticale},
                {c_quadrotriticale, "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end

end
