---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_doughnut_normal = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_doughnut_normal.init()

    return {
        description = "Normal doughnut",
        suggested = {
            "crop_wheat",                       -- group:food_wheat
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.food_doughnut_normal.exec()

    unilib.register_craftitem("unilib:food_doughnut_normal", "farming:donut", mode, {
        -- From farming:donut
        description = S("Normal Doughnut"),
        inventory_image = "unilib_food_doughnut_normal.png",
        -- N.B. No groups in original code
        groups = {food_doughnut = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_doughnut_normal", 4),
    })
    unilib.register_craft({
        -- From farming:donut
        output = "unilib:food_doughnut_normal 3",
        recipe = {
            {"", "group:food_wheat", ""},
            {"group:food_wheat", "group:food_sugar", "group:food_wheat"},
            {"", "group:food_wheat", ""},
        },
    })

end
