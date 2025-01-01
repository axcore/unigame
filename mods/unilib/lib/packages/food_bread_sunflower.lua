---------------------------------------------------------------------------------------------------
-- unilib mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    farming_redo
-- Code:    MIT
-- Media:   CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.food_bread_sunflower = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.farming.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.food_bread_sunflower.init()

    return {
        description = "Sunflower seed rbead",
        suggested = {
            "food_bread_ordinary",              -- group:food_bread
            "food_seed_sunflower_toasted",      -- group:food_sunflower_seeds_toasted
        },
    }

end

function unilib.pkg.food_bread_sunflower.exec()

    unilib.register_craftitem("unilib:food_bread_sunflower", "farming:sunflower_bread", mode, {
        -- From farming:sunflower_bread
        description = S("Sunflower Seed Bread"),
        inventory_image = "unilib_food_bread_sunflower.png",
        groups = {flammable = 2, food_sunflower_bread = 1},

        on_use = unilib.cuisine.eat_on_use("unilib:food_bread_sunflower", 8),
    })
    unilib.register_craft({
        -- From farming:sunflower_bread
        output = "unilib:food_bread_sunflower",
        recipe = {
            {
                "group:food_sunflower_seeds_toasted",
                "group:food_bread",
                "group:food_sunflower_seeds_toasted",
            },
        },
    })

end
