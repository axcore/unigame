---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    aotearoa
-- Code:    LGPLv2+
-- Media:   CC BY-SA 3.0 Unported
---------------------------------------------------------------------------------------------------

unilib.pkg.food_cake_seed = {}

local S = unilib.intllib
local mode = unilib.imported_mod_table.aotearoa.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_cake_seed.init()

    return {
        description = "Seed cake",
        depends = "ingredient_meal_seed",
    }

end

function unilib.pkg.food_cake_seed.exec()

    unilib.register_craftitem("unilib:food_cake_seed", "aotearoa:seed_cake", mode, {
        -- From aotearoa:seed_cake
        description = S("Seed Cake"),
        inventory_image = "unilib_food_cake_seed.png",
        -- N.B. No groups in original code
        groups = {food_seed_cake = 1},

        on_use = unilib.cuisine_eat_on_use("unilib:food_cake_seed", 5),
    })
    unilib.register_craft({
        -- From aotearoa:seed_cake
        type = "cooking",
        output = "unilib:food_cake_seed",
        recipe = "unilib:ingredient_meal_seed",
    })

end
