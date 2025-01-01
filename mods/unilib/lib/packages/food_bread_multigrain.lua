---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_multigrain = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_multigrain.init()

    return {
        description = "Multigrain bread",
        depends = "ingredient_flour_multigrain",
    }

end

function unilib.pkg.food_bread_multigrain.exec()

    unilib.register_craftitem("unilib:food_bread_multigrain", "farming:bread_multigrain", mode, {
        -- From farming:bread_multigrain
        description = S("Multigrain Bread"),
        inventory_image = "unilib_food_bread_multigrain.png",
        groups = {flammable = 2, food_bread = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_multigrain", 7),
    })
    unilib.register_craft({
        -- From farming:bread_multigrain
        type = "cooking",
        output = "unilib:food_bread_multigrain",
        recipe = "unilib:ingredient_flour_multigrain",
        cooktime = 15,
    })
    unilib.register_craft({
        -- From farming:bread_multigrain
        type = "fuel",
        recipe = "unilib:food_bread_multigrain",
        burntime = 1,
    })

end
