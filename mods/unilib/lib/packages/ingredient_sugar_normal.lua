---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_sugar_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_sugar_normal.init()

    return {
        description = "Normal sugar",
        depends = "plant_papyrus_ordinary",
    }

end

function unilib.pkg.ingredient_sugar_normal.exec()

    unilib.register_craftitem("unilib:ingredient_sugar_normal", "farming:sugar", mode, {
        -- From farming:sugar
        description = S("Normal Sugar"),
        inventory_image = "unilib_ingredient_sugar_normal.png",
        groups = {flammable = 3, food_sugar = 1},
    })
    unilib.register_craft({
        -- From farming:sugar
        type = "cooking",
        output = "unilib:ingredient_sugar_normal 2",
        recipe = "unilib:plant_papyrus_ordinary",
        cooktime = 3,
    })

end
