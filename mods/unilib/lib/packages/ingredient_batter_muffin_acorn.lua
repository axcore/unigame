---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_batter_muffin_acorn = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_batter_muffin_acorn.init()

    return {
        description = "Acorn muffin batter",
        depends = {"food_milk_coconut", "ingredient_acorn", "vessel_glass_empty"},
    }

end

function unilib.pkg.ingredient_batter_muffin_acorn.exec()

    unilib.register_craftitem(
        -- From moretrees:acorn_muffin_batter
        "unilib:ingredient_batter_muffin_acorn",
        "moretrees:acorn_muffin_batter",
        mode,
        {
            description = S("Acorn Muffin Batter"),
            inventory_image = "unilib_ingredient_batter_muffin_acorn.png",
        }
    )
    unilib.register_craft({
        -- From moretrees:acorn_muffin_batter
        type = "shapeless",
        output = "unilib:ingredient_batter_muffin_acorn",
        recipe = {
            "unilib:ingredient_acorn",
            "unilib:ingredient_acorn",
            "unilib:ingredient_acorn",
            "unilib:ingredient_acorn",
            "unilib:food_milk_coconut",
        },
        replacements = {
            {"food_milk_coconut", "unilib:vessel_glass_empty"},
        },
    })

end
