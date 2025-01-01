---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_pea = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_pea.init()

    return {
        description = "Peas",
        depends = "produce_pea",
    }

end

function unilib.pkg.food_pea.exec()

    unilib.register_craftitem("unilib:food_pea", "farming:peas", mode, {
        -- From farming:peas
        description = S("Peas"),
        inventory_image = "unilib_food_pea.png",
        groups = {flammable = 2, food_peas = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_pea", 1),
    })
    unilib.register_craft({
        -- From farming:peas
        output = "unilib:food_pea",
        recipe = {
            {"unilib:produce_pea_harvest"},
        },
    })

end
