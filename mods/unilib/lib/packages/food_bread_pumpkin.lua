---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_pumpkin = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_pumpkin.init()

    return {
        description = "Pumpkin bread",
        suggested = {
            "ingredient_flour_ordinary",        -- group:food_flour
            "produce_pumpkin_yellow",           -- group:food_pumpkin_slice
        },
    }

end

function unilib.pkg.food_bread_pumpkin.exec()

    unilib.register_craftitem("unilib:food_bread_pumpkin", "farming:pumpkin_bread", mode, {
        -- From farming:pumpkin_bread
        description = S("Pumpkin Bread"),
        inventory_image = "unilib_food_bread_pumpkin.png",
        groups = {flammable = 2, food_bread = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_bread_pumpkin", 8),
    })
    unilib.register_craft({
        -- From farming:pumpkin_bread
        type = "cooking",
        output = "unilib:food_bread_pumpkin",
        recipe = "unilib:food_bread_pumpkin_dough",
        cooktime = 10,
    })

    unilib.register_craftitem("unilib:food_bread_pumpkin_dough", "farming:pumpkin_dough", mode, {
        -- From farming:pumpkin_dough
        description = S("Pumpkin Dough"),
        inventory_image = "unilib_food_bread_pumpkin_dough.png",
    })
    unilib.register_craft({
        -- From farming:pumpkin_dough
        output = "unilib:food_bread_pumpkin_dough",
        recipe = {
            {"group:food_pumpkin_slice", "group:food_flour", "group:food_pumpkin_slice"},
        },
    })

end
