---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_doughnut_chocolate = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_doughnut_chocolate.init()

    return {
        description = "Chocolate doughnut",
        depends = "food_doughnut_normal",
        suggested = {
            "produce_cocoa_jungle",             -- group:food_cocoa
        },
    }

end

function unilib.pkg.food_doughnut_chocolate.exec()

    unilib.register_craftitem("unilib:food_doughnut_chocolate", "farming:donut_chocolate", mode, {
        -- From farming:donut_chocolate
        description = S("Chocolate Doughnut"),
        inventory_image = "unilib_food_doughnut_chocolate.png",
        -- N.B. No groups in original code
        groups = {food_doughnut = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_doughnut_chocolate", 6),
    })
    unilib.register_craft({
        -- From farming:donut_chocolate
        output = "unilib:food_doughnut_chocolate",
        recipe = {
            {"group:food_cocoa"},
            {"unilib:food_doughnut_normal"},
        },
    })

end
