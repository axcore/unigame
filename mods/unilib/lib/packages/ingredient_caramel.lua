---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_caramel = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_caramel.init()

    return {
        description = "Caramel",
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.ingredient_caramel.exec()

    unilib.register_craftitem("unilib:ingredient_caramel", "farming:caramel", mode, {
        -- From farming:caramel
        description = S("Caramel"),
        inventory_image = "unilib_ingredient_caramel.png",
    })
    unilib.register_craft({
        -- From farming:caramel
        type = "cooking",
        output = "unilib:ingredient_caramel",
        recipe = "group:food_sugar",
        cooktime = 6,
    })

end
