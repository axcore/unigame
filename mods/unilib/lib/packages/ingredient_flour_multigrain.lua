---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_flour_multigrain = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_flour_multigrain.init()

    return {
        description = "Multigrain flour",
        depends = {
            "crop_barley",
            "crop_oat",
            "crop_rye",
            "crop_wheat",
            "utensil_mortar_pestle",
        },
    }

end

function unilib.pkg.ingredient_flour_multigrain.exec()

    unilib.register_craftitem(
        -- From farming:flour_multigrain
        "unilib:ingredient_flour_multigrain",
        "farming:flour_multigrain",
        mode,
        {
            description = S("Multigrain Flour"),
            inventory_image = "unilib_ingredient_flour_multigrain.png",
            groups = {flammable = 1, food_flour = 1},
        }
    )
    unilib.register_craft({
        -- From farming:flour_multigrain
        type = "shapeless",
        output = "unilib:ingredient_flour_multigrain",
        recipe = {
            "unilib:crop_wheat_harvest",
            "unilib:crop_barley_harvest",
            "unilib:crop_oat_harvest",
            "unilib:crop_rye_harvest",
            "unilib:utensil_mortar_pestle",
        },
        replacements = {
            {"unilib:utensil_mortar_pestle", "unilib:utensil_mortar_pestle"},
        }
    })

end
