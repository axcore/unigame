---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming
-- Code:    MIT
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_ordinary = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_ordinary.init()

    return {
        description = "Ordinary flour",
        depends = "crop_wheat",
        optional = "utensil_mortar_pestle",
    }

end

function unilib.pkg.ingredient_flour_ordinary.exec()

    local c_wheat = "unilib:crop_wheat_harvest"

    unilib.register_craftitem("unilib:ingredient_flour_ordinary", "farming:flour", mode, {
        -- From farming:flour
        description = S("Ordinary Flour"),
        inventory_image = "unilib_ingredient_flour_ordinary.png",
        groups = {flammable = 1, food_flour = 1},
    })
    if not unilib.setting.mtgame_tweak_flag
            or unilib.global.pkg_executed_table["utensil_mortar_pestle"] == nil then

        unilib.register_craft({
            -- From minetest_game/farming, farming:flour
            type = "shapeless",
            output = "unilib:ingredient_flour_ordinary",
            recipe = {c_wheat, c_wheat, c_wheat, c_wheat},
        })

    else

        unilib.register_craft({
            -- From farming_redo, farming:flour
            output = "unilib:ingredient_flour_ordinary",
            recipe = {
                {c_wheat, c_wheat, c_wheat},
                {c_wheat, "unilib:utensil_mortar_pestle", ""},
            },
            replacements = {
                {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
            },
        })

    end

end
