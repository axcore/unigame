---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_sliced = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_sliced.init()

    return {
        description = "Sliced bread",
        depends = {"food_bread_ordinary", "utensil_board_cutting"},
    }

end

function unilib.pkg.food_bread_sliced.exec()

    unilib.register_craftitem("unilib:food_bread_sliced", "farming:bread_slice", mode, {
        -- From farming:bread_slice
        description = S("Sliced Bread"),
        inventory_image = "unilib_food_bread_sliced.png",
        -- N.B. no food_bread in original code
        groups = {flammable = 2, food_bread = 1, food_bread_slice = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_sliced", 1),
    })
    unilib.register_craft({
        -- From farming:bread_slice
        output = "unilib:food_bread_sliced 5",
        recipe = {
            {"unilib:utensil_board_cutting", "unilib:food_bread_ordinary"},
        },
        replacements = {
            {"unilib:utensil_board_cutting", "unilib:utensil_board_cutting"},
        },
    })

end
