---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_doughnut_apple = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_doughnut_apple.init()

    return {
        description = "Apple doughnut",
        depends = {"food_doughnut_normal", "fruit_apple"},
    }

end

function unilib.pkg.food_doughnut_apple.exec()

    unilib.register_craftitem("unilib:food_doughnut_apple", "farming:donut_apple", mode, {
        -- From farming:donut_apple
        description = S("Apple Doughnut"),
        inventory_image = "unilib_food_doughnut_apple.png",
        -- N.B. No groups in original code
        groups = {food_doughnut = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_doughnut_apple", 6),
    })
    unilib.register_craft({
        -- From farming:donut_apple
        output = "unilib:food_doughnut_apple",
        recipe = {
            {"unilib:fruit_apple"},
            {"unilib:food_doughnut_normal"},
        },
    })

end
