---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    moretrees
-- Code:    LGPL 3.0
-- Media:   CC-by-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_muffin_acorn = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.moretrees.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_muffin_acorn.init()

    return {
        description = "Acorn muffin",
        depends = "ingredient_batter_muffin_acorn",
    }

end

function unilib.pkg.food_muffin_acorn.exec()

    unilib.register_craftitem("unilib:food_muffin_acorn", "moretrees:acorn_muffin", mode, {
        -- From moretrees:acorn_muffin
        description = S("Acorn Muffin"),
        inventory_image = "unilib_food_muffin_acorn.png",
        -- N.B. No groups in original code
        groups = {food_acorn_muffin = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_muffin_acorn", 4),
    })
    unilib.register_craft({
        -- From moretrees:acorn_muffin
        type = "cooking",
        output = "unilib:food_muffin_acorn 4",
        recipe = "unilib:ingredient_batter_muffin_acorn",
    })

end
